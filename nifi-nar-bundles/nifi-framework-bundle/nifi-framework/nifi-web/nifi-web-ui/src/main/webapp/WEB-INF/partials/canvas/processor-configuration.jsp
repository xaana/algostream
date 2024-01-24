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
<div id="processor-configuration" layout="column" class="hidden large-dialog">
    <img src="images/? 74.png" style="width: 28px;height: 28px;margin: -2px 0px 1px -6px;position: absolute;right: 10px;top: 10px" onclick="$('#processor-configuration').hide()">
    <div id="processor-configuration-status-bar"></div>
    <div class="processor-configuration-tab-container dialog-content">
        <div id="processor-configuration-tabs" class="tab-container"></div>
        <div id="processor-configuration-tabs-content">
            <div id="processor-standard-settings-tab-content" class="configuration-tab">
                <div class="settings-left">
                    <div class="setting" style="display: block">
                        <div class="setting-name">Name</div>
                        <div id="processor-name-container" class="setting-field">
                            <input type="text" id="processor-name" name="processor-name"/>
                            <div class="processor-enabled-container">
                                <div id="processor-enabled" class="nf-checkbox checkbox-unchecked"></div>
                                <span class="nf-checkbox-label"> Enabled</span>
                            </div>
                        </div>
                    </div>
                    <div class="setting" style="margin-top: 15px">
                        <div class="setting-name">Id<span id="processor-id" style="margin-left: 10px;line-height: normal;width: 100%; color: #775351; font-size: 13px;font-weight: 500;"></span></div>
                    </div>
                    <div class="setting" style="margin-top: 15px">
                        <div class="setting-name">Type<span id="processor-type"style="margin-left: 10px;line-height: normal;width: 100%; color: #775351; font-size: 13px;font-weight: 500;"></span></div>
                    </div>
                    <div class="setting" style="margin-top: 15px">
                        <div class="setting-name">Bundle<span id="processor-bundle"style="margin-left: 10px;line-height: normal;width: 100%; color: #775351; font-size: 13px;font-weight: 500;"></span></div>
                    </div>
                    <div class="setting" style="margin-top: 15px">
                        <div class="penalty-duration-setting" style="margin-top: 15px">
                            <div class="setting-name">
                                Penalty duration
                                <div class="fa fa-question-circle" alt="Info" title="The amount of time used when this processor penalizes a FlowFile." style="left: 56%"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"></path></svg></div>
                            </div>
                            <div class="setting-field">
                                <input type="text" id="penalty-duration" name="penalty-duration" class="small-setting-input"/>
                            </div>
                        </div>
                        <div class="yield-duration-setting" style="margin-top: 15px">
                            <div class="setting-name">
                                Yield duration
                                <div class="fa fa-question-circle" alt="Info" title="When a processor yields, it will not be scheduled again until this amount of time elapses." style="left: 59%"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"></path></svg></div>
                            </div>
                            <div class="setting-field">
                                <input type="text" id="yield-duration" name="yield-duration" class="small-setting-input"/>
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="setting" style="margin-top: 15px">
                        <div class="bulletin-setting">
                            <div class="setting-name">
                                Bulletin level
                                <div class="fa fa-question-circle" alt="Info" title="The level at which this processor will generate bulletins." style="left: 52%"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"></path></svg></div>
                            </div>
                            <div class="setting-field">
                                <div id="bulletin-level-combo"></div>
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="spacer">&nbsp;</div>
            </div>
            <div id="processor-scheduling-tab-content" class="configuration-tab">
                <div class="settings-left">
                    <div class="setting">
                        <div class="scheduling-strategy-setting">
                            <div class="setting-name">
                                Scheduling strategy
                                <div class="fa fa-question-circle" alt="Info" title="The strategy used to schedule this processor."></div>
                            </div>
                            <div class="setting-field">
                                <div type="text" id="scheduling-strategy-combo"></div>
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div id="timer-driven-options" class="setting">
                        <div class="concurrently-schedulable-tasks-setting">
                            <div class="setting-name">
                                Concurrent tasks
                                <div class="fa fa-question-circle" alt="Info" title="The number of tasks that should be concurrently scheduled for this processor."></div>
                            </div>
                            <div class="setting-field">
                                <input type="text" id="timer-driven-concurrently-schedulable-tasks" name="timer-driven-concurrently-schedulable-tasks" class="small-setting-input"/>
                            </div>
                        </div>
                        <div class="scheduling-period-setting">
                            <div class="setting-name">
                                Run schedule
                                <div class="fa fa-question-circle" alt="Info" title="The amount of time that should elapse between task executions."></div>
                            </div>
                            <div class="setting-field">
                                <input type="text" id="timer-driven-scheduling-period" name="timer-driven-scheduling-period" class="small-setting-input"/>
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div id="cron-driven-options" class="setting">
                        <div class="concurrently-schedulable-tasks-setting">
                            <div class="setting-name">
                                Concurrent tasks
                                <div class="fa fa-question-circle" alt="Info" title="The number of tasks that should be concurrently scheduled for this processor."></div>
                            </div>
                            <div class="setting-field">
                                <input type="text" id="cron-driven-concurrently-schedulable-tasks" name="cron-driven-concurrently-schedulable-tasks" class="small-setting-input"/>
                            </div>
                        </div>
                        <div class="scheduling-period-setting">
                            <div class="setting-name">
                                Run schedule
                                <div class="fa fa-question-circle" alt="Info" title="The CRON expression that defines when this processor should run."></div>
                            </div>
                            <div class="setting-field">
                                <input type="text" id="cron-driven-scheduling-period" name="cron-driven-scheduling-period" class="small-setting-input"/>
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div id="execution-node-options" class="setting">
                        <div class="execution-node-setting">
                            <div class="setting-name">
                                Execution
                                <div class="fa fa-question-circle" alt="Info" title="The node(s) that this processor will be scheduled to run on when clustered."></div>
                            </div>
                            <div class="setting-field">
                                <div id="execution-node-combo"></div>
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="spacer">&nbsp;</div>
                <div id="run-duration-setting-container" class="settings-right">
                    <div class="setting">
                        <div class="setting-name">
                            Run duration
                            <div class="fa fa-question-circle" alt="Info"
                                 title="When scheduled to run, the processor will continue running for up to this duration. A run duration of 0ms will execute once when scheduled."></div>
                        </div>
                        <div class="setting-field" style="overflow: visible;">
                            <div id="run-duration-container">
                                <div id="run-duration-labels">
                                    <div id="run-duration-zero">0ms</div>
                                    <div id="run-duration-one">25ms</div>
                                    <div id="run-duration-two">50ms</div>
                                    <div id="run-duration-three">100ms</div>
                                    <div id="run-duration-four">250ms</div>
                                    <div id="run-duration-five">500ms</div>
                                    <div id="run-duration-six">1s</div>
                                    <div id="run-duration-seven">2s</div>
                                    <div class="clear"></div>
                                </div>
                                <div id="run-duration-slider"></div>
                                <div id="run-duration-explanation">
                                    <div id="min-run-duration-explanation">Lower latency</div>
                                    <div id="max-run-duration-explanation">Higher throughput</div>
                                    <div class="clear"></div>
                                </div>
                                <div id="run-duration-data-loss" class="hidden">
                                    <div class="processor-configuration-warning-icon"></div>
                                    Source Processors with a run duration greater than 0ms and no incoming connections could lose data when NiFi is shutdown.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="processor-properties-tab-content" class="configuration-tab">
                <div id="processor-properties"></div>
                <div id="processor-properties-verification-results" class="verification-results">
                    <div class="verification-results-header">Verification Results</div>
                    <div id="processor-properties-verification-results-listing" class="verification-results-listing"></div>
                </div>
            </div>
            <div id="processor-relationships-tab-content" class="configuration-tab" style="display: block">
                <div class="settings-left">
                    <div class="setting">
                        <div class="setting-name">
                            Automatically terminate / retry relationships
                            <div class="fa fa-question-circle" alt="Info" title="Will automatically terminate and/or retry FlowFiles sent to a given relationship if it is not defined elsewhere. If both terminate and retry are selected, any retry logic will happen first, then auto-termination."></div>
                        </div>
                        <div class="setting-field">
                            <div id="auto-action-relationship-names"></div>
                        </div>
                    </div>
                </div>
                <div class="settings-right">
                    <div class="retry-count-setting setting">
                        <div class="setting-name">
                            Number of Retry Attempts
                            <div class="fa fa-question-circle" alt="Info" title="For relationships set to retry, this number indicates how many times a FlowFile will attempt to reprocess before it is routed elsewhere."></div>
                        </div>
                        <div class="setting-field">
                            <input type="text" id="retry-attempt-count" class="small-setting-input">
                        </div>
                    </div>
                    <div class="backoff-policy-setting setting">
                        <div class="setting-name">
                            Retry Back Off Policy
                            <div class="fa fa-question-circle" alt="Info" title="Penalize: Retry attempts will occur in time, but the processor will continue to process other FlowFiles.&#013;&#013;Yield: No other FlowFile processing will occur until all retry attempts have been made."></div>
                        </div>
                        <div class="setting-field">
                            <input type="radio" id="penalizeFlowFile" name="backoffPolicy" value="PENALIZE_FLOWFILE">
                            <label for="penalizeFlowFile">Penalize</label>

                            <input type="radio" class="yield-radio" id="yieldEntireProcessor" name="backoffPolicy" value="YIELD_PROCESSOR">
                            <label for="yieldEntireProcessor">Yield</label>
                        </div>
                    </div>
                    <div class="max-backoff-setting setting">
                        <div class="setting-name">
                            Retry Maximum Back Off Period
                            <div class="fa fa-question-circle" alt="Info" title="Initial retries are based on the Penalty/Yield Duration time specified in the Settings tab. The duration time is repeatedly doubled for every subsequent retry attempt. This number indicates the maximum allowable time period before another retry attempt occurs."></div>
                        </div>
                        <div class="setting-field">
                            <input type="text" id="max-backoff-period" class="small-setting-input">
                        </div>
                    </div>
                </div>
            </div>
            <div id="processor-comments-tab-content" class="configuration-tab">
                <textarea cols="30" rows="4" id="processor-comments" name="processor-comments" class="setting-input"></textarea>
            </div>
        </div>
    </div>
</div>
<div id="new-processor-property-container"></div>
