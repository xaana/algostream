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
<div id="parameter-context-dialog" layout="column" class="hidden read-only" style="border-radius: 6px">
    <div id="parameter-context-status-bar"></div>
    <div class="parameter-context-tab-container dialog-content">
        <div id="parameter-context-tabs" class="tab-container"></div>
        <div id="parameter-context-tabs-content">
            <div id="parameter-context-standard-settings-tab-content" class="split-65-35 configuration-tab">
                <div class="settings-left">
                    <div id="parameter-context-id-setting" class="setting hidden">
                        <div class="setting-name">Id</div>
                        <div class="setting-field">
                            <div id="parameter-context-id-field" class="ellipsis"></div>
                        </div>
                    </div>
                    <div id="parameter-context-provider-setting" class="setting hidden"></div>
                    <div class="setting">
                        <div id="parameter-context-name-container" class="setting-field" style="margin-top: 98px">
                            <input type="text" id="parameter-context-name" class="edit-mode" name="parameter-context-name" placeholder="Name"/>
                            <div id="parameter-context-name-read-only" class="read-only ellipsis"></div>
                        </div>
                    </div>
                    <div class="setting">
                        <div class="setting-field parameter-context-description-container" style="margin-top: 26px">
                            <textarea id="parameter-context-description-field" class="edit-mode" rows="6" placeholder="Description"></textarea>
                            <div id="parameter-context-description-read-only" class="read-only"></div>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="spacer">&nbsp;</div>
                <div class="settings-right">
                    <div class="setting">
                        <div class="setting-name">
                            Referencing Components
                            <div class="fa fa-question-circle" alt="Info" title="Other components referencing this parameter context." style="left: 0; top: 5px "><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                        </div>
                        <div class="setting-field">
                            <div id="parameter-context-referencing-components"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="parameter-context-parameters-tab-content" class="split-65-35 configuration-tab">
                <div class="settings-left">
                    <div class="edit-mode">
                        <div id="add-parameter"><button class="button fa fa-plus" style="background-color: #F1EBFD; color: #834DF0; fill: currentColor;display: flex"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"><svg t="1700706708757" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2535" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"><path d="M482 152h60q8 0 8 8v704q0 8-8 8h-60q-8 0-8-8V160q0-8 8-8z" p-id="2536"></path><path d="M176 474h672q8 0 8 8v60q0 8-8 8H176q-8 0-8-8v-60q0-8 8-8z" p-id="2537"></path></svg></button></div>
                        <div class="clear"></div>
                    </div>
                    <div id="parameter-table"></div>
                    <div id="parameter-context-update-status" class="hidden">
                        <div class="setting">
                            <div class="setting-name">
                                Steps to update parameters
                            </div>
                            <div class="setting-field">
                                <ol id="parameter-context-update-steps"></ol>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="spacer">&nbsp;</div>
                <div id="parameter-context-usage" class="settings-right">
                    <div class="setting">
                        <div class="setting-name">
                            Parameter
                            <div class="referencing-components-loading"></div>
                        </div>
                        <div class="setting-field">
                            <div id="parameter-referencing-components-context" class="ellipsis"></div>
                        </div>
                    </div>
                    <div class="setting">
                        <div class="setting-name">
                            Referencing Components
                            <div class="fa fa-question-circle" alt="Info" title="Components referencing this parameter grouped by process group." style="top: 5px;left: 0"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                        </div>
                        <div id="parameter-referencing-components-container" class="setting-field">
                        </div>
                    </div>
                </div>
            </div>
            <div id="parameter-context-inheritance-tab-content" class="configuration-tab">
                <div id="parameter-context-inheritance-container">
                    <div class="settings-left">
                        <div class="setting">
                            <div class="setting-name">
                                <div class="fa fa-question-circle" alt="Info" title="Available Parameter Contexts that could be inherited from." style="left: 18%;top: 1px"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                            </div>
                            <div class="setting-field">
                                <ol id="parameter-context-available"></ol>
                            </div>
                        </div>
                    </div>
                    <div class="spacer">&nbsp;</div>
                </div>
                <div id="parameter-context-inheritance-containers">
                    <div class="settings-right">
                        <div class="setting">
                            <div class="setting-name">
                                <div class="fa fa-question-circle" alt="Info" title="Parameter Contexts selected for inheritance." style="left: -49%; top: 2px"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                            </div>
                            <div class="setting-field">
                                <ol id="parameter-context-selected"></ol>
                            </div>
                        </div>
                    </div>
                    </div>
                <div id="parameter-context-inheritance-container-read-only" style="display: none;">
                    <div class="settings-left">
                        <div class="setting">
                            <div class="setting-name">
                                Selected Parameter Context
                                <div class="fa fa-question-circle" alt="Info" title="Parameter Contexts selected for inheritance."></div>
                            </div>
                            <div class="setting-field">
                                <ol id="parameter-context-selected-read-only"></ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="inherited-parameter-contexts-message" class="ellipsis hidden">
        Inherited Parameter Contexts have been modified. Updated listing of Parameters is pending apply.
    </div>
</div>
<div id="parameter-dialog" class="dialog cancellable hidden" style="border-radius: 6px; min-height: 503px; min-width: 449px">
    <div class="dialog-content">
        <div class="setting">
            <div class="setting-field new-parameter-name-container">
                <input id="parameter-name" type="text" placeholder="Name"/>
            </div>
            <div class="clear"></div>
        </div>
        <div class="setting">
            <div class="setting-name">
                <div class="fa fa-question-circle" alt="Info" title="Parameter values do not support Expression Language or embedded parameter references."></div>
            </div>
            <div class="setting-field new-parameter-value-container" style="margin-left: -28px">
                <textarea id="parameter-value-field" placeholder="Value"></textarea>
                <div class="string-check-container" style="margin-top: 9px">
                    <div id="parameter-set-empty-string-field" class="nf-checkbox string-check checkbox-unchecked"></div>
                    <span class="string-check-label nf-checkbox-label" style="color: #B3B5B7; font-size: 14px">Set empty string</span>
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="setting">
            <div class="setting-field new-parameter-sensitive-value-container">
                <div class="setting-name" style="color: #666666; margin-top: 14px; font-size: 16px; margin-bottom: 34px">Sensitive value
                    <input id="parameter-sensitive-radio-button" type="radio" name="sensitive" value="sensitive" style="margin-left: 71px"/> Yes
                    <input id="parameter-not-sensitive-radio-button" type="radio" name="sensitive" value="plain" checked="checked" style="margin-left: 20px;"/> No
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="setting">
            <div class="setting-field new-parameter-description-container">
                <textarea id="parameter-description-field" rows="6" placeholder="Description"></textarea>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div id="parameter-context-updating-status">
        <div class='parameter-context-step ajax-loading'></div>
        <div class='status-message ellipsis'>Updating parameter context</div>
    </div>
</div>
<div id="referencing-components-template" class="referencing-components-template hidden clear">
    <div class="setting">
        <div class="setting-name">
            Referencing Processors
        </div>
        <div class="setting-field">
            <ul class="parameter-context-referencing-processors"></ul>
        </div>
    </div>
    <div class="setting">
        <div class="setting-name">
            Referencing Controller Services
        </div>
        <div class="setting-field">
            <ul class="parameter-context-referencing-controller-services"></ul>
        </div>
    </div>
    <div class="setting">
        <div class="setting-name">
            Unauthorized referencing components
        </div>
        <div class="setting-field">
            <ul class="parameter-context-referencing-unauthorized-components"></ul>
        </div>
    </div>
</div>
