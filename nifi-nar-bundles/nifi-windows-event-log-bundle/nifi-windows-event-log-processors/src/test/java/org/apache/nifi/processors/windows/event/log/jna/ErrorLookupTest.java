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
package org.apache.nifi.processors.windows.event.log.jna;

import com.sun.jna.platform.win32.Kernel32;
import com.sun.jna.platform.win32.WinError;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

/**
 * Running tests may require {@code junit.platform.launcher.interceptors.enabled}
 * property to be set to {@code true} to resolve class loading issues.
 */
@ExtendWith(MockitoExtension.class)
public class ErrorLookupTest {
    @Mock
    Kernel32 kernel32;

    private ErrorLookup errorLookup;

    @BeforeEach
    public void setup() {
        errorLookup = new ErrorLookup(kernel32);
    }

    @Test
    public void testErrorLookupExists() {
        when(kernel32.GetLastError()).thenReturn(WinError.ERROR_INSUFFICIENT_BUFFER);
        assertEquals("ERROR_INSUFFICIENT_BUFFER(" + WinError.ERROR_INSUFFICIENT_BUFFER + ")", errorLookup.getLastError());
    }

    @Test
    public void testErrorLookupDoesntExist() {
        when(kernel32.GetLastError()).thenReturn(Integer.MAX_VALUE);
        assertEquals(Integer.toString(Integer.MAX_VALUE), errorLookup.getLastError());
    }
}
