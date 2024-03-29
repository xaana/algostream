/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.apache.nifi.web.security.x509.ocsp;

import java.io.IOException;
import java.math.BigInteger;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SignatureException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.bouncycastle.asn1.x500.X500Name;
import org.bouncycastle.asn1.x509.ExtendedKeyUsage;
import org.bouncycastle.asn1.x509.Extension;
import org.bouncycastle.asn1.x509.KeyPurposeId;
import org.bouncycastle.asn1.x509.KeyUsage;
import org.bouncycastle.asn1.x509.SubjectPublicKeyInfo;
import org.bouncycastle.cert.X509CertificateHolder;
import org.bouncycastle.cert.X509v3CertificateBuilder;
import org.bouncycastle.cert.jcajce.JcaX509CertificateConverter;
import org.bouncycastle.operator.ContentSigner;
import org.bouncycastle.operator.OperatorCreationException;
import org.bouncycastle.operator.jcajce.JcaContentSignerBuilder;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class OcspCertificateValidatorTest {
    private static final Logger logger = LoggerFactory.getLogger(OcspCertificateValidatorTest.class);

    private static final int KEY_SIZE = 2048;

    private static final long YESTERDAY = System.currentTimeMillis() - 24 * 60 * 60 * 1000;
    private static final long ONE_YEAR_FROM_NOW = System.currentTimeMillis() + 365L * 24 * 60 * 60 * 1000;
    private static final String SIGNATURE_ALGORITHM = "SHA256withRSA";

    /**
     * Generates a public/private RSA keypair using the default key size.
     *
     * @return the keypair
     * @throws NoSuchAlgorithmException if the RSA algorithm is not available
     */
    private static KeyPair generateKeyPair() throws NoSuchAlgorithmException {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(KEY_SIZE);
        return keyPairGenerator.generateKeyPair();
    }

    /**
     * Generates a signed certificate using an on-demand keypair.
     *
     * @param dn the DN
     * @return the certificate
     * @throws IOException               if an exception occurs
     * @throws NoSuchAlgorithmException  if an exception occurs
     * @throws CertificateException      if an exception occurs
     * @throws OperatorCreationException if an exception occurs
     */
    private static X509Certificate generateCertificate(String dn) throws IOException, NoSuchAlgorithmException, CertificateException,
            OperatorCreationException {
        KeyPair keyPair = generateKeyPair();
        return generateCertificate(dn, keyPair);
    }

    /**
     * Generates a signed certificate with a specific keypair.
     *
     * @param dn      the DN
     * @param keyPair the public key will be included in the certificate and the the private key is used to sign the certificate
     * @return the certificate
     * @throws IOException               if an exception occurs
     * @throws CertificateException      if an exception occurs
     * @throws OperatorCreationException if an exception occurs
     */
    private static X509Certificate generateCertificate(String dn, KeyPair keyPair) throws IOException, CertificateException,
            OperatorCreationException {
        PrivateKey privateKey = keyPair.getPrivate();
        ContentSigner sigGen = new JcaContentSignerBuilder(SIGNATURE_ALGORITHM).build(privateKey);
        SubjectPublicKeyInfo subPubKeyInfo = SubjectPublicKeyInfo.getInstance(keyPair.getPublic().getEncoded());
        Date startDate = new Date(YESTERDAY);
        Date endDate = new Date(ONE_YEAR_FROM_NOW);

        X509v3CertificateBuilder certBuilder = new X509v3CertificateBuilder(
                new X500Name(dn),
                BigInteger.valueOf(System.currentTimeMillis()),
                startDate, endDate,
                new X500Name(dn),
                subPubKeyInfo);

        // Set certificate extensions
        // (1) digitalSignature extension
        certBuilder.addExtension(Extension.keyUsage, true,
                new KeyUsage(KeyUsage.digitalSignature | KeyUsage.keyEncipherment | KeyUsage.dataEncipherment | KeyUsage.keyAgreement));

        // (2) extendedKeyUsage extension
        final List<KeyPurposeId> ekUsages = new ArrayList<>();
        ekUsages.add(KeyPurposeId.id_kp_clientAuth);
        ekUsages.add(KeyPurposeId.id_kp_serverAuth);
        certBuilder.addExtension(Extension.extendedKeyUsage, false, new ExtendedKeyUsage(ekUsages.toArray(new KeyPurposeId[0])));

        // Sign the certificate
        X509CertificateHolder certificateHolder = certBuilder.build(sigGen);
        return new JcaX509CertificateConverter().getCertificate(certificateHolder);
    }

    /**
     * Generates a certificate signed by the issuer key.
     *
     * @param dn        the subject DN
     * @param issuerDn  the issuer DN
     * @param issuerKey the issuer private key
     * @return the certificate
     * @throws NoSuchAlgorithmException  if an exception occurs
     * @throws CertificateException      if an exception occurs
     * @throws OperatorCreationException if an exception occurs
     */
    private static X509Certificate generateIssuedCertificate(String dn, String issuerDn, PrivateKey issuerKey) throws NoSuchAlgorithmException, CertificateException,
            OperatorCreationException {
        KeyPair keyPair = generateKeyPair();
        return generateIssuedCertificate(dn, keyPair.getPublic(), issuerDn, issuerKey);
    }

    /**
     * Generates a certificate with a specific public key signed by the issuer key.
     *
     * @param dn        the subject DN
     * @param publicKey the subject public key
     * @param issuerDn  the issuer DN
     * @param issuerKey the issuer private key
     * @return the certificate
     * @throws CertificateException      if an exception occurs
     * @throws OperatorCreationException if an exception occurs
     */
    private static X509Certificate generateIssuedCertificate(String dn, PublicKey publicKey, String issuerDn, PrivateKey issuerKey) throws
            CertificateException, OperatorCreationException {
        ContentSigner sigGen = new JcaContentSignerBuilder(SIGNATURE_ALGORITHM).build(issuerKey);
        SubjectPublicKeyInfo subPubKeyInfo = SubjectPublicKeyInfo.getInstance(publicKey.getEncoded());
        Date startDate = new Date(YESTERDAY);
        Date endDate = new Date(ONE_YEAR_FROM_NOW);

        X509v3CertificateBuilder v3CertGen = new X509v3CertificateBuilder(
                new X500Name(issuerDn),
                BigInteger.valueOf(System.currentTimeMillis()),
                startDate, endDate,
                new X500Name(dn),
                subPubKeyInfo);

        X509CertificateHolder certificateHolder = v3CertGen.build(sigGen);
        return new JcaX509CertificateConverter().getCertificate(certificateHolder);
    }

    @Test
    public void testShouldGenerateCertificate() throws Exception {
        // Arrange
        final String testDn = "CN=This is a test";

        // Act
        X509Certificate certificate = generateCertificate(testDn);
        logger.info("Generated certificate: \n{}", certificate);

        // Assert
        assertEquals(testDn, certificate.getSubjectX500Principal().getName());
        assertEquals(testDn, certificate.getIssuerX500Principal().getName());
        certificate.verify(certificate.getPublicKey());
    }

    @Test
    public void testShouldGenerateCertificateFromKeyPair() throws Exception {
        // Arrange
        final String testDn = "CN=This is a test";
        final KeyPair keyPair = generateKeyPair();

        // Act
        X509Certificate certificate = generateCertificate(testDn, keyPair);
        logger.info("Generated certificate: \n{}", certificate);

        // Assert
        assertEquals(keyPair.getPublic(), certificate.getPublicKey());
        assertEquals(testDn, certificate.getSubjectX500Principal().getName());
        assertEquals(testDn, certificate.getIssuerX500Principal().getName());
        certificate.verify(certificate.getPublicKey());
    }

    @Test
    public void testShouldGenerateIssuedCertificate() throws Exception {
        // Arrange
        final String testDn = "CN=This is a signed test";
        final String issuerDn = "CN=Issuer CA";
        final KeyPair issuerKeyPair = generateKeyPair();
        final PrivateKey issuerPrivateKey = issuerKeyPair.getPrivate();

        final X509Certificate issuerCertificate = generateCertificate(issuerDn, issuerKeyPair);
        logger.info("Generated issuer certificate: \n{}", issuerCertificate);

        // Act
        X509Certificate certificate = generateIssuedCertificate(testDn, issuerDn, issuerPrivateKey);
        logger.info("Generated signed certificate: \n{}", certificate);

        // Assert
        assertEquals(issuerKeyPair.getPublic(), issuerCertificate.getPublicKey());
        assertEquals(testDn,  certificate.getSubjectX500Principal().getName());
        assertEquals(issuerDn, certificate.getIssuerX500Principal().getName());
        certificate.verify(issuerCertificate.getPublicKey());

        assertThrows(SignatureException.class, () -> certificate.verify(certificate.getPublicKey()));
    }
}