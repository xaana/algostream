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
<md-toolbar id="header" layout-align="space-between center" layout="column" class="md-small">
    <img id="nifi-logo" src="images/ms-nifi-logo.jpg">
    <div flex layout="column" layout-align="space-between center">
        <div id="component-container" style="margin-top: 10px">
            <button title="{{appCtrl.serviceProvider.headerCtrl.toolboxCtrl.config.type.processor}}"
                    id="processor-component"
                    class="component-button icon icon-processor"
                    ng-disabled="!appCtrl.nf.CanvasUtils.canWriteCurrentGroup();"
                    nf-draggable="appCtrl.serviceProvider.headerCtrl.toolboxCtrl.draggableComponentConfig(appCtrl.serviceProvider.headerCtrl.toolboxCtrl.processorComponent);">
                <img src="images/processor.svg" style="height: 34px; width: 34px;margin-top: 4px">
                <span class="component-button-grip"></span>
            </button>
            <button title="{{appCtrl.serviceProvider.headerCtrl.toolboxCtrl.config.type.inputPort}}"
                    id="port-in-component"
                    class="component-button icon icon-port-in"
                    ng-disabled="!appCtrl.nf.CanvasUtils.canWriteCurrentGroup();"
                    nf-draggable="appCtrl.serviceProvider.headerCtrl.toolboxCtrl.draggableComponentConfig(appCtrl.serviceProvider.headerCtrl.toolboxCtrl.inputPortComponent);" style="margin-top: 30px">
                <img src="images/input.svg" style="height: 34px; width: 34px;margin-top: 4px">
                <span class="component-button-grip"></span>
            </button>
            <button title="{{appCtrl.serviceProvider.headerCtrl.toolboxCtrl.config.type.outputPort}}"
                    id="port-out-component"
                    class="component-button icon icon-port-out"
                    ng-disabled="!appCtrl.nf.CanvasUtils.canWriteCurrentGroup();"
                    nf-draggable="appCtrl.serviceProvider.headerCtrl.toolboxCtrl.draggableComponentConfig(appCtrl.serviceProvider.headerCtrl.toolboxCtrl.outputPortComponent);" style="margin-top: 30px">
                <img src="images/output.svg" style="height: 34px; width: 34px;margin-top: 4px">
                <span class="component-button-grip"></span>
            </button>
            <button title="{{appCtrl.serviceProvider.headerCtrl.toolboxCtrl.config.type.processGroup}}"
                    id="group-component"
                    class="component-button icon icon-group"
                    ng-disabled="!appCtrl.nf.CanvasUtils.canWriteCurrentGroup();"
                    nf-draggable="appCtrl.serviceProvider.headerCtrl.toolboxCtrl.draggableComponentConfig(appCtrl.serviceProvider.headerCtrl.toolboxCtrl.groupComponent);" style="margin-top: 30px">
                <img src="images/group.svg" style="height: 34px; width: 34px;margin-top: 4px">
                <span class="component-button-grip"></span>
            </button>
            <button title="{{appCtrl.serviceProvider.headerCtrl.toolboxCtrl.config.type.remoteProcessGroup}}"
                    id="group-remote-component"
                    class="component-button icon icon-group-remote"
                    ng-disabled="!appCtrl.nf.CanvasUtils.canWriteCurrentGroup();"
                    nf-draggable="appCtrl.serviceProvider.headerCtrl.toolboxCtrl.draggableComponentConfig(appCtrl.serviceProvider.headerCtrl.toolboxCtrl.remoteGroupComponent);" style="margin-top: 30px">
                <img src="images/group-remote.svg" style="height: 34px; width: 34px;margin-top: 4px">
                <span class="component-button-grip"></span>
            </button>
            <button title="{{appCtrl.serviceProvider.headerCtrl.toolboxCtrl.config.type.funnel}}"
                    id="funnel-component"
                    class="component-button icon icon-funnel"
                    ng-disabled="!appCtrl.nf.CanvasUtils.canWriteCurrentGroup();"
                    nf-draggable="appCtrl.serviceProvider.headerCtrl.toolboxCtrl.draggableComponentConfig(appCtrl.serviceProvider.headerCtrl.toolboxCtrl.funnelComponent);" style="margin-top: 30px">
                <img src="images/funnel.svg" style="height: 34px; width: 34px;margin-top: 4px">
                <span class="component-button-grip"></span>
            </button>
            <button title="{{appCtrl.serviceProvider.headerCtrl.toolboxCtrl.config.type.label}}"
                    id="label-component"
                    class="component-button icon icon-label"
                    ng-disabled="!appCtrl.nf.CanvasUtils.canWriteCurrentGroup();"
                    nf-draggable="appCtrl.serviceProvider.headerCtrl.toolboxCtrl.draggableComponentConfig(appCtrl.serviceProvider.headerCtrl.toolboxCtrl.labelComponent);" style="margin-top: 30px">
                <img src="images/label.svg" style="height: 34px; width: 34px;margin-top: 4px">
                <span class="component-button-grip"></span>
            </button>
        </div>
<%--        <div layout="row" layout-align="space-between center">--%>
<%--&lt;%&ndash;            <div layout-align="space-between end" layout="column" class="space-between">&ndash;%&gt;--%>
<%--&lt;%&ndash;                <div layout="column" layout-align="space-between center" id="current-user-container">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <span id="anonymous-user-alert" class="hidden fa fa-warning"></span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <div></div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <div id="current-user"></div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <div id="login-link-container">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <span id="login-link" class="link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                          ng-click="appCtrl.serviceProvider.headerCtrl.loginCtrl.shell.launch();">log in</span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <div id="logout-link-container" style="display: none;">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <span id="logout-link" class="link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                          ng-click="appCtrl.serviceProvider.headerCtrl.logoutCtrl.logout();">log out</span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;            </div>&ndash;%&gt;--%>
<%--            <md-menu md-position-mode="target-right" md-offset="-1 44">--%>
<%--&lt;%&ndash;                <button md-menu-origin id="global-menu-button" ng-click="$mdMenu.open()">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <div class="fa fa-navicon"></div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </button>&ndash;%&gt;--%>
<%--&lt;%&ndash;     aria-disabled="false"&ndash;%&gt;--%>
<%--&lt;%&ndash;                <md-menu-content id="global-menu-content" class="global-menu-open">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="reporting-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.summary.shell.launch();">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="fa fa-table"></i>Summary&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="counters-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.counters.shell.launch();"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-class="{disabled: !appCtrl.nf.Common.canAccessCounters()}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="icon icon-counter"></i>Counters&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="bulletin-board-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.bulletinBoard.shell.launch();">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="fa fa-sticky-note-o"></i>Bulletin Board&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-divider></md-menu-divider>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item&ndash;%&gt;--%>
<%--&lt;%&ndash;                            layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="provenance-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.dataProvenance.shell.launch();"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-class="{disabled: !appCtrl.nf.Common.canAccessProvenance()}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="icon icon-provenance"></i>Data Provenance&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-divider></md-menu-divider>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="flow-settings-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.controllerSettings.shell.launch();">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="fa fa-wrench"></i>Controller Settings&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="parameter-contexts-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.parameterContexts.shell.launch();">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="fa"></i>Parameter Contexts&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item ng-if="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.cluster.visible();"&ndash;%&gt;--%>
<%--&lt;%&ndash;                                  layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="cluster-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.cluster.shell.launch();"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-class="{disabled: !appCtrl.nf.Common.canAccessController()}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="fa fa-cubes"></i>Cluster&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="history-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.flowConfigHistory.shell.launch();">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="fa fa-history"></i>Flow Configuration History&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="status-history-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.nodeStatusHistory.shell.launch();">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="fa fa-area-chart"></i>Node Status History&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-divider ng-if="appCtrl.nf.CanvasUtils.isManagedAuthorizer()"></md-menu-divider>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center" ng-if="appCtrl.nf.CanvasUtils.isManagedAuthorizer()">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="users-link" layout="column"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.users.shell.launch();"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-class="{disabled: !(appCtrl.nf.Common.canAccessTenants())}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="fa fa-users"></i>Users&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center" ng-if="appCtrl.nf.CanvasUtils.isManagedAuthorizer()">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="policies-link" layout="column"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.policies.shell.launch();"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-class="{disabled: !(appCtrl.nf.Common.canAccessTenants() && appCtrl.nf.Common.canModifyPolicies())}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="fa fa-key"></i>Policies&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-divider></md-menu-divider>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="templates-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.templates.shell.launch();">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="icon icon-template"></i>Templates&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-divider></md-menu-divider>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="help-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.help.shell.launch();">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="fa fa-question-circle"></i>Help&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <md-menu-item layout-align="space-around center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a id="about-link"&ndash;%&gt;--%>
<%--&lt;%&ndash;                           ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.about.modal.show();">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <i class="fa fa-info-circle"></i>About&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </md-menu-item>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </md-menu-content>&ndash;%&gt;--%>
<%--            </md-menu>--%>
<%--        </div>--%>
    </div>
</md-toolbar>
