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
package org.apache.nifi.web.security.knox;

import org.apache.nifi.util.NiFiProperties;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class KnoxAuthenticationFilterTest {

    private static final String COOKIE_NAME = "hadoop-jwt";

    private KnoxAuthenticationFilter knoxAuthenticationFilter;

    @BeforeEach
    public void setUp() throws Exception {
        final NiFiProperties nifiProperties = Mockito.mock(NiFiProperties.class);
        when(nifiProperties.isKnoxSsoEnabled()).thenReturn(true);
        when(nifiProperties.getKnoxCookieName()).thenReturn(COOKIE_NAME);

        knoxAuthenticationFilter = new KnoxAuthenticationFilter();
        knoxAuthenticationFilter.setProperties(nifiProperties);
    }

    @Test
    public void testInsecureHttp() {
        final HttpServletRequest request = mock(HttpServletRequest.class);
        when(request.isSecure()).thenReturn(false);
        assertNull(knoxAuthenticationFilter.attemptAuthentication(request));
    }

    @Test
    public void testNullCookies() {
        final HttpServletRequest request = mock(HttpServletRequest.class);
        when(request.isSecure()).thenReturn(true);
        when(request.getCookies()).thenReturn(null);
        assertNull(knoxAuthenticationFilter.attemptAuthentication(request));
    }

    @Test
    public void testNoCookies() {
        final HttpServletRequest request = mock(HttpServletRequest.class);
        when(request.isSecure()).thenReturn(true);
        when(request.getCookies()).thenReturn(new Cookie[] {});
        assertNull(knoxAuthenticationFilter.attemptAuthentication(request));
    }

    @Test
    public void testWrongCookieName() {
        final String jwt = "my-jwt";

        final Cookie knoxCookie = mock(Cookie.class);
        when(knoxCookie.getName()).thenReturn("not-hadoop-jwt");
        when(knoxCookie.getValue()).thenReturn(jwt);

        final HttpServletRequest request = mock(HttpServletRequest.class);
        when(request.isSecure()).thenReturn(true);
        when(request.getCookies()).thenReturn(new Cookie[] {knoxCookie});

        final KnoxAuthenticationRequestToken authRequest = (KnoxAuthenticationRequestToken) knoxAuthenticationFilter.attemptAuthentication(request);
        assertNull(authRequest);
    }

    @Test
    public void testKnoxCookie() {
        final String jwt = "my-jwt";

        final Cookie knoxCookie = mock(Cookie.class);
        when(knoxCookie.getName()).thenReturn(COOKIE_NAME);
        when(knoxCookie.getValue()).thenReturn(jwt);

        final HttpServletRequest request = mock(HttpServletRequest.class);
        when(request.isSecure()).thenReturn(true);
        when(request.getCookies()).thenReturn(new Cookie[] {knoxCookie});

        final KnoxAuthenticationRequestToken authRequest = (KnoxAuthenticationRequestToken) knoxAuthenticationFilter.attemptAuthentication(request);
        assertNotNull(authRequest);
        assertEquals(jwt, authRequest.getToken());
    }
}