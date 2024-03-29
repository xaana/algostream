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
package org.apache.nifi.cluster.manager;

import org.apache.nifi.cluster.protocol.NodeIdentifier;
import org.apache.nifi.web.api.entity.FlowAnalysisRuleEntity;

import java.util.Map;
import java.util.Set;

public class FlowAnalysisRulesEntityMerger {

    private static final FlowAnalysisRuleEntityMerger flowAnalysisRuleEntityMerger = new FlowAnalysisRuleEntityMerger();

    /**
     * Merges multiple FlowAnalysisRuleEntity responses.
     *
     * @param flowAnalysisRuleEntities entities being returned to the client
     * @param entityMap all node responses
     */
    public static void mergeFlowAnalysisRules(final Set<FlowAnalysisRuleEntity> flowAnalysisRuleEntities, final Map<String, Map<NodeIdentifier, FlowAnalysisRuleEntity>> entityMap) {
        for (final FlowAnalysisRuleEntity entity : flowAnalysisRuleEntities) {
            flowAnalysisRuleEntityMerger.merge(entity, entityMap.get(entity.getId()));
        }
    }
}
