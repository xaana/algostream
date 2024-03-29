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
package org.apache.nifi.cdc.mysql.event;

import com.github.shyiko.mysql.binlog.event.WriteRowsEventData;
import org.apache.nifi.cdc.event.TableInfo;

import java.io.Serializable;

/**
 * This class represents information about rows written/added to a MySQL table
 */
public class InsertRowsEventInfo extends BaseBinlogRowEventInfo<Serializable[]> {

    public InsertRowsEventInfo(TableInfo tableInfo, Long timestamp, String binlogFilename, Long binlogPosition, WriteRowsEventData data) {
        super(tableInfo, INSERT_EVENT, timestamp, binlogFilename, binlogPosition, data.getIncludedColumns(), data.getRows());
    }

    public InsertRowsEventInfo(TableInfo tableInfo, Long timestamp, String binlogGtidSet, WriteRowsEventData data) {
        super(tableInfo, INSERT_EVENT, timestamp, binlogGtidSet, data.getIncludedColumns(), data.getRows());
    }
}
