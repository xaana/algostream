/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.apache.nifi.processors.solr;

import java.io.IOException;
import java.security.PrivilegedExceptionAction;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.apache.nifi.annotation.lifecycle.OnScheduled;
import org.apache.nifi.annotation.lifecycle.OnStopped;
import org.apache.nifi.components.PropertyDescriptor;
import org.apache.nifi.components.ValidationContext;
import org.apache.nifi.components.ValidationResult;
import org.apache.nifi.kerberos.KerberosCredentialsService;
import org.apache.nifi.kerberos.KerberosUserService;
import org.apache.nifi.processor.AbstractProcessor;
import org.apache.nifi.processor.ProcessContext;
import org.apache.nifi.processor.ProcessSession;
import org.apache.nifi.processor.exception.ProcessException;
import org.apache.nifi.security.krb.KerberosAction;
import org.apache.nifi.security.krb.KerberosKeytabUser;
import org.apache.nifi.security.krb.KerberosLoginException;
import org.apache.nifi.security.krb.KerberosPasswordUser;
import org.apache.nifi.security.krb.KerberosUser;
import org.apache.nifi.ssl.SSLContextService;
import org.apache.solr.client.solrj.SolrClient;

import static org.apache.nifi.processors.solr.SolrUtils.BASIC_PASSWORD;
import static org.apache.nifi.processors.solr.SolrUtils.BASIC_USERNAME;
import static org.apache.nifi.processors.solr.SolrUtils.COLLECTION;
import static org.apache.nifi.processors.solr.SolrUtils.KERBEROS_USER_SERVICE;
import static org.apache.nifi.processors.solr.SolrUtils.SOLR_LOCATION;
import static org.apache.nifi.processors.solr.SolrUtils.SOLR_TYPE;
import static org.apache.nifi.processors.solr.SolrUtils.SOLR_TYPE_CLOUD;
import static org.apache.nifi.processors.solr.SolrUtils.SOLR_TYPE_STANDARD;
import static org.apache.nifi.processors.solr.SolrUtils.SSL_CONTEXT_SERVICE;

/**
 * A base class for processors that interact with Apache Solr.
 *
 */
public abstract class SolrProcessor extends AbstractProcessor {

    private volatile SolrClient solrClient;
    private volatile String solrLocation;
    private volatile String basicUsername;
    private volatile String basicPassword;
    private volatile boolean basicAuthEnabled = false;

    private volatile KerberosUser kerberosUser;

    @OnScheduled
    public final void onScheduled(final ProcessContext context) throws IOException {
        this.solrLocation =  context.getProperty(SOLR_LOCATION).evaluateAttributeExpressions().getValue();
        this.basicUsername = context.getProperty(BASIC_USERNAME).evaluateAttributeExpressions().getValue();
        this.basicPassword = context.getProperty(BASIC_PASSWORD).evaluateAttributeExpressions().getValue();
        if (!StringUtils.isBlank(basicUsername) && !StringUtils.isBlank(basicPassword)) {
            basicAuthEnabled = true;
        }

        this.solrClient = createSolrClient(context, solrLocation);

        final KerberosUserService kerberosUserService = context.getProperty(KERBEROS_USER_SERVICE).asControllerService(KerberosUserService.class);
        if (kerberosUserService != null) {
            this.kerberosUser = kerberosUserService.createKerberosUser();
        }
    }

    protected KerberosUser createKerberosKeytabUser(final KerberosCredentialsService kerberosCredentialsService) {
        return new KerberosKeytabUser(kerberosCredentialsService.getPrincipal(), kerberosCredentialsService.getKeytab());
    }

    protected KerberosUser createKerberosPasswordUser(final String principal, final String password) {
        return new KerberosPasswordUser(principal, password);
    }

    @OnStopped
    public final void closeClient() {
        if (solrClient != null) {
            try {
                solrClient.close();
            } catch (IOException e) {
                getLogger().debug("Error closing SolrClient", e);
            }
        }

        if (kerberosUser != null) {
            try {
                kerberosUser.logout();
                kerberosUser = null;
            } catch (final KerberosLoginException e) {
                getLogger().debug("Error logging out keytab user", e);
            }
        }
    }

    @Override
    public final void onTrigger(final ProcessContext context, final ProcessSession session) throws ProcessException {
        final KerberosUser kerberosUser = getKerberosUser();
        if (kerberosUser == null) {
            doOnTrigger(context, session);
        } else {
            // wrap doOnTrigger in a privileged action
            final PrivilegedExceptionAction<Void> action = () -> {
                doOnTrigger(context, session);
                return null;
            };

            // execute the privileged action as the given keytab user
            final KerberosAction kerberosAction = new KerberosAction<>(kerberosUser, action, getLogger());
            try {
                kerberosAction.execute();
            } catch (ProcessException e) {
                context.yield();
                throw e;
            }
        }
    }

    /**
     * This should be implemented just like the normal onTrigger method. When a KerberosCredentialsService is configured,
     * this method will be wrapped in a PrivilegedAction and executed with the credentials of the service, otherwise this
     * will be executed like a a normal call to onTrigger.
     */
    protected abstract void doOnTrigger(final ProcessContext context, final ProcessSession session) throws ProcessException;

    /**
     * Create a SolrClient based on the type of Solr specified.
     *
     * @param context
     *          The context
     * @return an HttpSolrClient or CloudSolrClient
     */
    protected SolrClient createSolrClient(final ProcessContext context, final String solrLocation) {
        return SolrUtils.createSolrClient(context, solrLocation);
    }

    /**
     * Returns the {@link org.apache.solr.client.solrj.SolrClient} that was created by the
     * {@link #createSolrClient(org.apache.nifi.processor.ProcessContext, String)} method
     *
     * @return an HttpSolrClient or CloudSolrClient
     */
    protected final SolrClient getSolrClient() {
        return solrClient;
    }

    protected final String getSolrLocation() {
        return solrLocation;
    }

    protected final String getUsername() {
        return basicUsername;
    }

    protected final String getPassword() {
        return basicPassword;
    }

    protected final boolean isBasicAuthEnabled() {
        return basicAuthEnabled;
    }

    protected final KerberosUser getKerberosUser() {
        return kerberosUser;
    }

    @Override
    final protected Collection<ValidationResult> customValidate(ValidationContext context) {
        final List<ValidationResult> problems = new ArrayList<>();

        // For solr cloud the location will be the ZooKeeper host:port so we can't validate the SSLContext, but for standard solr
        // we can validate if the url starts with https we need an SSLContextService, if it starts with http we can't have an SSLContextService
        if (SOLR_TYPE_STANDARD.getValue().equals(context.getProperty(SOLR_TYPE).getValue())) {
            final String solrLocation = context.getProperty(SOLR_LOCATION).evaluateAttributeExpressions().getValue();
            if (solrLocation != null) {
                final SSLContextService sslContextService = context.getProperty(SSL_CONTEXT_SERVICE).asControllerService(SSLContextService.class);
                if (solrLocation.startsWith("https:") && sslContextService == null) {
                    problems.add(new ValidationResult.Builder()
                            .subject(SSL_CONTEXT_SERVICE.getDisplayName())
                            .valid(false)
                            .explanation("an SSLContextService must be provided when using https")
                            .build());
                } else if (solrLocation.startsWith("http:") && sslContextService != null) {
                    problems.add(new ValidationResult.Builder()
                            .subject(SSL_CONTEXT_SERVICE.getDisplayName())
                            .valid(false)
                            .explanation("an SSLContextService can not be provided when using http")
                            .build());
                }
            }
        }

        if (context.getProperty(BASIC_USERNAME).isSet() && context.getProperty(KERBEROS_USER_SERVICE).isSet()) {
            problems.add(new ValidationResult.Builder()
                .subject("Basic Auth and Kerberos")
                .explanation("Cannot set both Basic Auth Username and Kerberos User Service")
                .valid(false)
                .build());
        }

        invalidIfEmpty(context, BASIC_USERNAME, problems);
        invalidIfEmpty(context, BASIC_PASSWORD, problems);

        final Collection<ValidationResult> otherProblems = this.additionalCustomValidation(context);
        if (otherProblems != null) {
            problems.addAll(otherProblems);
        }

        if (SOLR_TYPE_CLOUD.getValue().equals(context.getProperty(SOLR_TYPE).getValue()) && !context.getProperty(COLLECTION).isSet()) {
            problems.add(new ValidationResult.Builder()
                .subject(COLLECTION.getName())
                .input(context.getProperty(COLLECTION).getValue())
                .valid(false)
                .explanation("A collection must specified for Solr Type of Cloud")
                .build());

        }

        return problems;
    }

    private void invalidIfEmpty(final ValidationContext context, final PropertyDescriptor descriptor, final List<ValidationResult> problems) {
        if (context.getProperty(descriptor).isSet() && context.getProperty(descriptor).evaluateAttributeExpressions().getValue().isBlank()) {
            problems.add(new ValidationResult.Builder()
                .subject(descriptor.getDisplayName())
                .explanation("Property cannot be an empty string and cannot reference environment variables that do not exist")
                .valid(false)
                .build());
        }
    }

    /**
     * Allows additional custom validation to be done. This will be called from
     * the parent's customValidation method.
     *
     * @param context
     *            The context
     * @return Validation results indicating problems
     */
    protected Collection<ValidationResult> additionalCustomValidation(ValidationContext context) {
        return new ArrayList<>();
    }

}
