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
package org.apache.nifi.cluster.protocol.jaxb.message;

import jakarta.xml.bind.annotation.adapters.XmlAdapter;
import org.apache.nifi.cluster.protocol.NodeBulletins;

/**
 */
public class NodeBulletinsAdapter extends XmlAdapter<AdaptedNodeBulletins, NodeBulletins> {

    @Override
    public AdaptedNodeBulletins marshal(final NodeBulletins hb) {

        final AdaptedNodeBulletins adaptedBulletins = new AdaptedNodeBulletins();

        if (hb != null) {
            // set node identifier
            adaptedBulletins.setNodeIdentifier(hb.getNodeIdentifier());

            // set payload
            adaptedBulletins.setPayload(hb.getPayload());
        }

        return adaptedBulletins;
    }

    @Override
    public NodeBulletins unmarshal(final AdaptedNodeBulletins adaptedBulletins) {
        return new NodeBulletins(adaptedBulletins.getNodeIdentifier(), adaptedBulletins.getPayload());
    }

}
