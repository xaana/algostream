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
package org.apache.nifi.controller.cluster;

import org.apache.nifi.cluster.coordination.ClusterCoordinator;
import org.apache.nifi.cluster.coordination.node.ClusterRoles;
import org.apache.nifi.cluster.coordination.node.NodeConnectionStatus;
import org.apache.nifi.cluster.protocol.HeartbeatPayload;
import org.apache.nifi.cluster.protocol.NodeIdentifier;
import org.apache.nifi.cluster.protocol.NodeProtocolSender;
import org.apache.nifi.cluster.protocol.ProtocolException;
import org.apache.nifi.cluster.protocol.message.CommsTimingDetails;
import org.apache.nifi.cluster.protocol.message.HeartbeatMessage;
import org.apache.nifi.cluster.protocol.message.HeartbeatResponseMessage;
import org.apache.nifi.controller.leader.election.LeaderElectionManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * Uses Leader Election Manager in order to determine which node is the elected
 * Cluster Coordinator and to indicate that this node is part of the cluster.
 * Once the Cluster Coordinator is known, heartbeats are sent directly to the
 * Cluster Coordinator.
 */
public class ClusterProtocolHeartbeater implements Heartbeater {

    private static final Logger logger = LoggerFactory.getLogger(ClusterProtocolHeartbeater.class);

    private final NodeProtocolSender protocolSender;
    private final LeaderElectionManager electionManager;
    private final ClusterCoordinator clusterCoordinator;

    public ClusterProtocolHeartbeater(final NodeProtocolSender protocolSender, final ClusterCoordinator clusterCoordinator, final LeaderElectionManager electionManager) {
        this.protocolSender = protocolSender;
        this.clusterCoordinator = clusterCoordinator;
        this.electionManager = electionManager;
    }

    @Override
    public String getHeartbeatAddress() {
        final Optional<String> clusterCoordinator = electionManager.getLeader(ClusterRoles.CLUSTER_COORDINATOR);
        return clusterCoordinator.orElseThrow(() -> new ProtocolException("Unable to send heartbeat: Cluster Coordinator not found"));
    }


    @Override
    public synchronized void send(final HeartbeatMessage heartbeatMessage) throws IOException {
        final long sendStart = System.nanoTime();
        final long findCoordinatorStart = System.nanoTime();
        final String heartbeatAddress = getHeartbeatAddress();
        final long findCoordinatorNanos = System.nanoTime() - findCoordinatorStart;

        final HeartbeatResponseMessage responseMessage = protocolSender.heartbeat(heartbeatMessage, heartbeatAddress);

        final byte[] payloadBytes = heartbeatMessage.getHeartbeat().getPayload();
        final HeartbeatPayload payload = HeartbeatPayload.unmarshal(payloadBytes);
        final List<NodeConnectionStatus> nodeStatusList = payload.getClusterStatus();
        final Map<NodeIdentifier, Long> updateIdMap = nodeStatusList.stream().collect(
                Collectors.toMap(status -> status.getNodeIdentifier(), status -> status.getUpdateIdentifier()));

        final List<NodeConnectionStatus> updatedStatuses = responseMessage.getUpdatedNodeStatuses();
        if (updatedStatuses != null) {
            for (final NodeConnectionStatus updatedStatus : updatedStatuses) {
                final NodeIdentifier nodeId = updatedStatus.getNodeIdentifier();
                final Long updateId = updateIdMap.get(nodeId);

                final boolean updated = clusterCoordinator.resetNodeStatus(updatedStatus, updateId == null ? -1L : updateId);
                if (updated) {
                    logger.info("After receiving heartbeat response, updated status of {} to {}", updatedStatus.getNodeIdentifier(), updatedStatus);
                } else {
                    logger.debug("After receiving heartbeat response, did not update status of {} to {} because the update is out-of-date", updatedStatus.getNodeIdentifier(), updatedStatus);
                }
            }
        }


        final long sendNanos = System.nanoTime() - sendStart;
        final long sendMillis = TimeUnit.NANOSECONDS.toMillis(sendNanos);

        final String flowElectionMessage = responseMessage.getFlowElectionMessage();
        final String formattedElectionMessage = flowElectionMessage == null ? "" : "; " + flowElectionMessage;

        final CommsTimingDetails timingDetails = responseMessage.getCommsTimingDetails();

        logger.info("Heartbeat created at {} and sent to {} at {}; determining Cluster Coordinator took {} millis; DNS lookup for coordinator took {} millis; connecting to coordinator took {} " +
                "millis; sending heartbeat took {} millis; receiving first byte from response took {} millis; receiving full response took {} millis; total time was {} millis{}",
            Instant.ofEpochMilli(heartbeatMessage.getHeartbeat().getCreatedTimestamp()),
            heartbeatAddress,
            Instant.now(),
            TimeUnit.NANOSECONDS.toMillis(findCoordinatorNanos),
            timingDetails.getDnsLookupMillis(),
            timingDetails.getConnectMillis(),
            timingDetails.getSendRequestMillis(),
            timingDetails.getReceiveFirstByteMillis(),
            timingDetails.getReceiveFullResponseMillis(),
            sendMillis,
            formattedElectionMessage);
    }

    @Override
    public void close() throws IOException {
    }
}
