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
package org.apache.nifi.web.api.dto.provenance.lineage;

import io.swagger.v3.oas.annotations.media.Schema;
import org.apache.nifi.web.api.dto.util.TimestampAdapter;

import jakarta.xml.bind.annotation.XmlType;
import jakarta.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import java.util.Date;

/**
 * A link between an event or flowfile within a provenance lineage.
 */
@XmlType(name = "provenanceLink")
public class ProvenanceLinkDTO {

    private String sourceId;
    private String targetId;
    private String flowFileUuid;
    private Date timestamp;
    private Long millis;

    /**
     * @return source node id
     */
    @Schema(description = "The source node id of the link."
    )
    public String getSourceId() {
        return sourceId;
    }

    public void setSourceId(String sourceId) {
        this.sourceId = sourceId;
    }

    /**
     * @return target node id
     */
    @Schema(description = "The target node id of the link."
    )
    public String getTargetId() {
        return targetId;
    }

    public void setTargetId(String targetId) {
        this.targetId = targetId;
    }

    /**
     * @return flowfile uuid that traversed this link
     */
    @Schema(description = "The flowfile uuid that traversed the link."
    )
    public String getFlowFileUuid() {
        return flowFileUuid;
    }

    public void setFlowFileUuid(String flowFileUuid) {
        this.flowFileUuid = flowFileUuid;
    }

    /**
     * @return timestamp of this link (based on the destination)
     */
    @XmlJavaTypeAdapter(TimestampAdapter.class)
    @Schema(description = "The timestamp of the link (based on the destination).",
            type = "string"
    )
    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    /**
     * @return number of millis since epoch
     */
    @Schema(description = "The timestamp of this link in milliseconds."
    )
    public Long getMillis() {
        return millis;
    }

    public void setMillis(Long millis) {
        this.millis = millis;
    }
}
