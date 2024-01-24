<%--
 Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" session="false" %>
<div id="process-group-configuration">
    <div id="process-group-configuration-header-text" class="settings-header-text">Process Group Configuration</div>
    <div class="settings-container">
        <div>
            <div id="process-group-configuration-tabs" class="settings-tabs tab-container" style="left: 50%"></div>
            <div class="clear"></div>
        </div>
        <div id="process-group-configuration-tabs-content">
            <button id="add-process-group-configuration-controller-service" class="add-button fa fa-plus" title="Create a new controller service">
                <img src="images/? 87.png" style="width: 28px;height: 28px;margin: -1px 0 0 -6px;">
            </button>
            <div id="general-process-group-configuration-tab-content" class="configuration-tab">
                <div id="general-process-group-configuration">
                    <div class="setting">
                        <div class="setting-name">Process group name</div>
                        <span id="process-group-id" class="hidden"></span>
                        <div class="editable setting-field">
                            <input type="text" id="process-group-name" class="setting-input"/>
                        </div>
                        <div class="read-only setting-field">
                            <span id="read-only-process-group-name" class="unset"></span>
                        </div>
                    </div>
                    <div class="setting" style="margin-left: 50%; margin-top: -50px;">
                        <div class="setting-name">Process group parameter context</div>
                        <div class="editable setting-field">
                            <div id="process-group-parameter-context-combo"></div>
                            <div id="parameter-contexts-recursive-container">
                                <div id="parameter-contexts-recursive" class="nf-checkbox checkbox-unchecked"></div>
                                <div class="nf-checkbox-label">Apply recursively</div>
                                <div class="fa fa-question-circle" alt="Info" title="When checked Parameter Context will be applied to the Process Group and all the embedded Process Groups recursively, if the user has the proper permissions on all the respective components. If the user does not have the proper permissions on any embedded Process Group, then the Parameter Context will not be applied for any components."></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="read-only setting-field">
                            <span id="read-only-process-group-parameter-context" class="unset">Unauthorized</span>
                        </div>
                    </div>
                    <div class="setting">
                        <div class="setting-name">Execution Engine</div>
                        <div class="editable setting-field">
                            <div id="process-group-execution-engine-combo"></div>
                        </div>
                        <div class="read-only setting-field">
                            <span id="read-only-process-group-execution-engine" class="unset"></span>
                        </div>
                    </div>
                    <div id="stateless-group-options" class="setting">
                        <div class="setting">
                            <div class="setting-name">Max Concurrent Tasks</div>
                            <div class="editable setting-field">
                                <input type="text" id="process-group-max-concurrent-tasks" class="setting-input"/>
                            </div>
                            <div class="read-only setting-field">
                                <span id="read-only-process-group-max-concurrent-tasks" class="unset"></span>
                            </div>
                        </div>
                        <div class="setting">
                            <div class="setting-name">Stateless Flow Timeout</div>
                            <div class="editable setting-field">
                                <input type="text" id="process-group-stateless-flow-timeout" class="setting-input"/>
                            </div>
                            <div class="read-only setting-field">
                                <span id="read-only-process-group-stateless-flow-timeout" class="unset"></span>
                            </div>
                        </div>
                    </div>
                    <div class="setting" style="margin-left: 50%; top: -45px;">
                        <div class="setting-name">Process group FlowFile concurrency</div>
                        <div class="editable setting-field">
                            <div id="process-group-flowfile-concurrency-combo"></div>
                        </div>
                        <div class="read-only setting-field">
                            <span id="read-only-process-group-flowfile-concurrency" class="unset"></span>
                        </div>
                    </div>
                    <div class="setting" style="top: -30px;">
                        <div class="setting-name">Process group outbound policy</div>
                        <div class="editable setting-field">
                            <div id="process-group-outbound-policy-combo"></div>
                        </div>
                        <div class="read-only setting-field">
                            <span id="read-only-process-group-outbound-policy" class="unset"></span>
                        </div>
                    </div>
                    <div class="setting" style="margin-left: 50%;top: -80px;">
                        <div class="setting-name">Default FlowFile Expiration</div>
                        <div class="editable setting-field">
                            <input type="text" id="process-group-default-flowfile-expiration" class="setting-input"/>
                        </div>
                        <div class="read-only setting-field">
                            <span id="read-only-process-group-default-flowfile-expiration" class="unset"></span>
                        </div>
                    </div>
                    <div class="setting" style="top: -60px;">
                        <div class="setting-name">Default Back Pressure Object Threshold</div>
                        <div class="editable setting-field">
                            <input type="text" id="process-group-default-back-pressure-object-threshold" class="setting-input"/>
                        </div>
                        <div class="read-only setting-field">
                            <span id="read-only-process-group-default-back-pressure-object-threshold" class="unset"></span>
                        </div>
                    </div>
                    <div class="setting" style="margin-left: 50%;top: -110px;">
                        <div class="setting-name">Default Back Pressure Data Size Threshold</div>
                        <div class="editable setting-field">
                            <input type="text" id="process-group-default-back-pressure-data-size-threshold" class="setting-input"/>
                        </div>
                        <div class="read-only setting-field">
                            <span id="read-only-process-group-default-back-pressure-data-size-threshold" class="unset"></span>
                        </div>
                    </div>
                    <div class="setting" style="top: -90px;">
                        <div class="setting-name">Log File Suffix
                        <div class="fa fa-question-circle" alt="Info" title="Turns on dedicated logging. When left empty log messages will be logged only to the primary app log. When set messages logged by components in this group will be sent to the standard app log, as well as a separate log file, with the provided name, specific to this group."></div>
                        </div>
                        <div class="editable setting-field">
                            <input type="text" id="process-group-log-file-suffix" class="setting-input"/>
                        </div>
                        <div class="read-only setting-field">
                            <span id="read-only-process-group-log-file-suffix" class="unset"></span>
                        </div>
                    </div>
                    <div class="setting" style="margin-left: 50%;top: -140px;">
                        <div class="setting-name">Process group comments</div>
                        <div class="editable setting-field">
                            <textarea id="process-group-comments" class="setting-input"></textarea>
                        </div>
                        <div class="read-only setting-field">
                            <span id="read-only-process-group-comments" class="unset"></span>
                        </div>
                    </div>
                    <div class="editable settings-buttons" style="left: 80%">
                        <div id="process-group-configuration-save" class="button">Apply</div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <div id="process-group-controller-services-tab-content" class="configuration-tab">
                <div id="process-group-controller-services-table" class="settings-table"></div>
            </div>
        </div>
    </div>
    <div id="process-group-refresh-container" style="bottom: -195px">
        <button id="process-group-configuration-refresh-button" class="refresh-button pointer fa fa-refresh" title="Refresh"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"><svg t="1701308554362" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6573" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" style="margin-top: 2px; margin-left: -3px; fill: #5734D3"><path d="M896 198.4 896 198.4l0 179.2 0 0c0 19.2-6.4 32-19.2 44.8-12.8 12.8-32 19.2-44.8 19.2l0 0-179.2 0 0 0c-19.2 0-32-6.4-44.8-19.2-25.6-25.6-25.6-64 0-89.6C620.8 320 633.6 313.6 652.8 313.6l0 0 25.6 0C627.2 275.2 576 256 518.4 256 441.6 256 377.6 281.6 332.8 332.8l0 0c-25.6 25.6-64 25.6-89.6 0-25.6-25.6-25.6-64 0-89.6l0 0C313.6 172.8 409.6 128 518.4 128c96 0 185.6 38.4 249.6 96L768 198.4l0 0c0-19.2 6.4-32 19.2-44.8 25.6-25.6 64-25.6 89.6 0C889.6 160 896 179.2 896 198.4zM416 691.2c-12.8 12.8-32 19.2-44.8 19.2l0 0L352 710.4C396.8 748.8 448 768 505.6 768c70.4 0 134.4-25.6 179.2-76.8l0 0c25.6-25.6 64-25.6 89.6 0 25.6 25.6 25.6 64 0 89.6l0 0C710.4 851.2 614.4 896 505.6 896c-96 0-185.6-38.4-249.6-96l0 32 0 0c0 19.2-6.4 32-19.2 44.8-25.6 25.6-64 25.6-89.6 0C134.4 864 128 844.8 128 825.6l0 0 0-179.2 0 0c0-19.2 6.4-32 19.2-44.8C160 588.8 172.8 582.4 192 582.4l0 0 179.2 0 0 0c19.2 0 32 6.4 44.8 19.2C441.6 627.2 441.6 665.6 416 691.2z" p-id="6574"></path></svg></button>
        <div class="last-refreshed-container">
            Last updated:&nbsp;<span id="process-group-configuration-last-refreshed" class="last-refreshed"></span>
        </div>
        <div id="process-group-configuration-loading-container" class="loading-container"></div>
        <div id="flow-cs-availability" class="hidden">Listed services are available to all descendant Processors and services of this Process Group.</div>
        <div class="clear"></div>
    </div>
</div>
