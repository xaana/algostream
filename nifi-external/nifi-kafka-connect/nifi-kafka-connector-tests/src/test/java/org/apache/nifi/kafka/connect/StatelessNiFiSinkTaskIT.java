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

package org.apache.nifi.kafka.connect;

import org.apache.kafka.connect.errors.RetriableException;
import org.apache.kafka.connect.sink.SinkRecord;
import org.apache.kafka.connect.sink.SinkTaskContext;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;
import org.mockito.Mockito;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class StatelessNiFiSinkTaskIT {
    private final File DEFAULT_OUTPUT_DIRECTORY = new File("target/sink-output");

    @Test
    public void testSimpleFlow(TestInfo testInfo) throws IOException {
        final StatelessNiFiSinkTask sinkTask = new StatelessNiFiSinkTask();
        sinkTask.initialize(Mockito.mock(SinkTaskContext.class));

        final Map<String, String> properties = createDefaultProperties(testInfo);
        sinkTask.start(properties);

        final SinkRecord record = new SinkRecord("topic", 0, null, "key", null, "Hello World", 0L);

        final File[] files = DEFAULT_OUTPUT_DIRECTORY.listFiles();
        if (files != null) {
            for (final File file : files) {
                assertTrue(file.delete(), "Failed to delete existing file " + file.getAbsolutePath());
            }
        }

        sinkTask.put(Collections.singleton(record));
        sinkTask.flush(Collections.emptyMap());

        final File[] outputFiles = DEFAULT_OUTPUT_DIRECTORY.listFiles();
        assertNotNull(outputFiles);
        assertEquals(1, outputFiles.length);
        final File outputFile = outputFiles[0];

        final String output = new String(Files.readAllBytes(outputFile.toPath()));
        assertEquals("Hello World", output);

        sinkTask.stop();
    }

    @Test
    public void testParameters(TestInfo testInfo) throws IOException {
        final StatelessNiFiSinkTask sinkTask = new StatelessNiFiSinkTask();
        sinkTask.initialize(Mockito.mock(SinkTaskContext.class));

        final Map<String, String> properties = createDefaultProperties(testInfo);
        properties.put("parameter.Directory", "target/sink-output-2");
        sinkTask.start(properties);

        final SinkRecord record = new SinkRecord("topic", 0, null, "key", null, "Hello World", 0L);

        final File outputDir = new File("target/sink-output-2");
        final File[] files = outputDir.listFiles();
        if (files != null) {
            for (final File file : files) {
                assertTrue(file.delete(), "Failed to delete existing file " + file.getAbsolutePath());
            }
        }

        sinkTask.put(Collections.singleton(record));
        sinkTask.flush(Collections.emptyMap());

        final File[] outputFiles = outputDir.listFiles();
        assertNotNull(outputFiles);
        assertEquals(1, outputFiles.length);
        final File outputFile = outputFiles[0];

        final String output = new String(Files.readAllBytes(outputFile.toPath()));
        assertEquals("Hello World", output);

        sinkTask.stop();
    }

    @Test
    public void testWrongOutputPort(TestInfo testInfo) {
        final StatelessNiFiSinkTask sinkTask = new StatelessNiFiSinkTask();
        sinkTask.initialize(Mockito.mock(SinkTaskContext.class));

        final Map<String, String> properties = createDefaultProperties(testInfo);
        properties.put(StatelessNiFiSinkConfig.FAILURE_PORTS, "Success, Failure");
        sinkTask.start(properties);

        final SinkRecord record = new SinkRecord("topic", 0, null, "key", null, "Hello World", 0L);

        final File[] files = DEFAULT_OUTPUT_DIRECTORY.listFiles();
        if (files != null) {
            for (final File file : files) {
                assertTrue(file.delete(), "Failed to delete existing file " + file.getAbsolutePath());
            }
        }

        assertThrows(RetriableException.class, () -> {
                    sinkTask.put(Collections.singleton(record));
                    sinkTask.flush(Collections.emptyMap());
                }, "Expected RetriableException to be thrown");
    }

    private Map<String, String> createDefaultProperties(TestInfo testInfo) {
        final Map<String, String> properties = new HashMap<>();
        properties.put(StatelessNiFiCommonConfig.DATAFLOW_TIMEOUT, "30 sec");
        properties.put(StatelessNiFiSinkConfig.INPUT_PORT_NAME, "In");
        properties.put(StatelessNiFiCommonConfig.FLOW_SNAPSHOT, "src/test/resources/flows/Write_To_File.json");
        properties.put(StatelessNiFiCommonConfig.NAR_DIRECTORY, "target/nifi-kafka-connector-bin/nars");
        properties.put(StatelessNiFiCommonConfig.WORKING_DIRECTORY, "target/nifi-kafka-connector-bin/working");
        properties.put(StatelessNiFiCommonConfig.DATAFLOW_NAME, testInfo.getTestMethod().get().getName());
        return properties;
    }
}
