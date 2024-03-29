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

package org.apache.nifi.processors.kafka.pubsub;

import org.apache.nifi.util.MockComponentLog;
import org.apache.nifi.util.MockFlowFile;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Timeout;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import static org.junit.jupiter.api.Assertions.assertThrows;

public class TestInFlightMessageTracker {

    @Test
    @Timeout(value = 5000, unit = TimeUnit.MILLISECONDS)
    public void testAwaitCompletionWhenComplete() throws InterruptedException, TimeoutException {
        final MockFlowFile flowFile = new MockFlowFile(1L);

        final InFlightMessageTracker tracker = new InFlightMessageTracker(new MockComponentLog("1", "unit-test"));
        tracker.incrementSentCount(flowFile);

        verifyNotComplete(tracker);

        tracker.incrementSentCount(flowFile);
        verifyNotComplete(tracker);

        tracker.incrementAcknowledgedCount(flowFile);
        verifyNotComplete(tracker);

        tracker.incrementAcknowledgedCount(flowFile);
        tracker.awaitCompletion(1L);
    }

    @Test
    @Timeout(value = 5000, unit = TimeUnit.MILLISECONDS)
    public void testAwaitCompletionWhileWaiting() throws InterruptedException, ExecutionException {
        final MockFlowFile flowFile = new MockFlowFile(1L);

        final InFlightMessageTracker tracker = new InFlightMessageTracker(new MockComponentLog("1", "unit-test"));
        tracker.incrementSentCount(flowFile);

        verifyNotComplete(tracker);

        tracker.incrementSentCount(flowFile);
        verifyNotComplete(tracker);

        try (ExecutorService exec = Executors.newFixedThreadPool(1)) {
            final Future<?> future  = exec.submit(() -> {
                try {
                    tracker.awaitCompletion(10000L);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            });

            tracker.incrementAcknowledgedCount(flowFile);
            tracker.incrementAcknowledgedCount(flowFile);

            future.get();
        }
    }

    private void verifyNotComplete(final InFlightMessageTracker tracker) {
        assertThrows(TimeoutException.class, () -> tracker.awaitCompletion(10L));
    }
}
