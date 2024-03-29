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
package org.apache.nifi.web.api.dto.action.details;

import io.swagger.v3.oas.annotations.media.Schema;
import org.apache.nifi.web.api.dto.util.DateTimeAdapter;

import jakarta.xml.bind.annotation.XmlType;
import jakarta.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import java.util.Date;

/**
 * Details of a purge operation.
 */
@XmlType(name = "purgeDetails")
public class PurgeDetailsDTO extends ActionDetailsDTO {

    private Date endDate;

    /**
     * @return end date for this purge action
     */
    @XmlJavaTypeAdapter(DateTimeAdapter.class)
    @Schema(description = "The end date for the purge action.",
            type = "string"
    )
    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
