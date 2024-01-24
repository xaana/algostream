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
<nf-breadcrumbs
        breadcrumbs="appCtrl.serviceProvider.breadcrumbsCtrl.getBreadcrumbs();"
        click-func="appCtrl.nf.CanvasUtils.getComponentByType('ProcessGroup').enterGroup"
        highlight-crumb-id="appCtrl.nf.CanvasUtils.getGroupId();"
        separator-func="appCtrl.nf.Common.isDefinedAndNotNull"
        is-tracking="appCtrl.serviceProvider.breadcrumbsCtrl.isTracking"
        get-version-control-class="appCtrl.serviceProvider.breadcrumbsCtrl.getVersionControlClass"
        get-version-control-tooltip="appCtrl.serviceProvider.breadcrumbsCtrl.getVersionControlTooltip">
</nf-breadcrumbs>
<div id="graph-controls">
    <div id="navigation-control" class="graph-control" style="border-radius: 6px;">
        <%--        <div class="graph-control-docked pointer fa fa-compass" title="Navigate"--%>
        <%--             ng-click="appCtrl.serviceProvider.graphControlsCtrl.undock($event)">--%>
        <%--        </div>--%>
        <%--        <div class="graph-control-header-container hidden pointer"--%>
        <%--             ng-click="appCtrl.serviceProvider.graphControlsCtrl.expand($event)">--%>
        <%--            <div class="graph-control-header-icon fa fa-compass">--%>
        <%--            </div>--%>
        <%--            <div class="graph-control-header">Navigate</div>--%>
        <%--            <div class="graph-control-header-action">--%>
        <%--                <div class="graph-control-expansion fa fa-plus-square-o pointer"></div>--%>
        <%--            </div>--%>
        <%--            <div class="clear"></div>--%>
        <%--        </div>--%>
        <div class="graph-control-content hidden">
            <div id="navigation-buttons">
                <div id="naviagte-zoom-in" class="action-button" title="Zoom In"
                     ng-click="appCtrl.serviceProvider.graphControlsCtrl.navigateCtrl.zoomIn();">
                    <button style="background-color: #FFFFFF">
                        <div class="graph-control-action-icon fa fa-search-plus"><svg xmlns="http://www.w3.org/2000/svg" width="16.638" height="16.64" viewBox="0 0 16.638 16.64"><defs><style>.a{}</style></defs><path class="a" d="M91.525,83.969a7.447,7.447,0,0,1,5.636,12.316l3.378,3.377a.544.544,0,1,1-.768.769l-3.378-3.378a7.447,7.447,0,1,1-4.869-13.085Zm0,1.087a6.36,6.36,0,1,0,4.439,10.916l.053-.064a.546.546,0,0,1,.063-.054,6.36,6.36,0,0,0-4.555-10.8Zm-.016,3.432a.485.485,0,0,1,.485.485v1.941h1.942a.485.485,0,1,1,0,.971H91.993v1.942a.485.485,0,1,1-.971,0V91.884H89.082a.485.485,0,1,1,0-.971h1.941V88.973a.485.485,0,0,1,.485-.485Z" transform="translate(-84.079 -83.968)"/></svg>
                        </div>
                    </button>
                </div>
                <div class="button-spacer-large">&nbsp;</div>
                <div id="naviagte-zoom-out" class="action-button" title="Zoom Out"
                     ng-click="appCtrl.serviceProvider.graphControlsCtrl.navigateCtrl.zoomOut();">
                    <button style="background-color: #FFFFFF">
                        <div class="graph-control-action-icon fa fa-search-minus"><svg xmlns="http://www.w3.org/2000/svg" width="16.638" height="16.64" viewBox="0 0 16.638 16.64"><defs><style>.a{}</style></defs><path class="a" d="M91.525,83.969a7.447,7.447,0,0,1,5.636,12.316l3.378,3.377a.544.544,0,1,1-.768.769l-3.378-3.378a7.447,7.447,0,1,1-4.869-13.085Zm0,1.087a6.36,6.36,0,1,0,4.439,10.916l.053-.064a.546.546,0,0,1,.063-.054,6.36,6.36,0,0,0-4.555-10.8Zm.469,5.859h1.942a.485.485,0,1,1,0,.971H89.082a.485.485,0,1,1,0-.971h2.912Z" transform="translate(-84.079 -83.968)"/></svg>
                        </div>
                    </button>
                </div>
                <div class="button-spacer-large">&nbsp;</div>
                <div id="naviagte-zoom-fit" class="action-button" title="Fit"
                     ng-click="appCtrl.serviceProvider.graphControlsCtrl.navigateCtrl.zoomFit();">
                    <button style="background-color: #FFFFFF">
                        <div class="graph-control-action-icon icon icon-zoom-fit"><svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" viewBox="0 0 21 21"><defs><style>.a{}</style></defs><path class="a" d="M83.26,78.593h-3.5a.7.7,0,0,0-.467.117,1.4,1.4,0,0,0-.583.583.7.7,0,0,0-.117.467v3.5a1.167,1.167,0,1,0,2.333,0v-.7l1.517,1.517a1.127,1.127,0,0,0,1.633,0,1.128,1.128,0,0,0,0-1.633L82.56,80.927h.7a1.167,1.167,0,1,0,0-2.333Zm0,18.667h-.7l1.517-1.517a1.155,1.155,0,0,0-1.633-1.633l-1.517,1.517v-.7a1.167,1.167,0,0,0-2.333,0v3.5a.7.7,0,0,0,.117.467,1.406,1.406,0,0,0,.583.583.7.7,0,0,0,.467.117h3.5a1.167,1.167,0,0,0,0-2.333ZM98.893,78.71a.7.7,0,0,0-.467-.117h-3.5a1.167,1.167,0,0,0,0,2.333h.7L94.11,82.443a1.128,1.128,0,0,0,0,1.633,1.128,1.128,0,0,0,1.633,0L97.26,82.56v.7a1.167,1.167,0,1,0,2.333,0v-3.5a.7.7,0,0,0-.117-.467,1.407,1.407,0,0,0-.583-.583Zm-.467,15.05a1.1,1.1,0,0,0-1.167,1.167v.7L95.743,94.11a1.155,1.155,0,0,0-1.633,1.633l1.517,1.517h-.7a1.167,1.167,0,0,0,0,2.333h3.5a.7.7,0,0,0,.467-.117,1.409,1.409,0,0,0,.583-.583.7.7,0,0,0,.117-.467v-3.5a1.1,1.1,0,0,0-1.167-1.167Z" transform="translate(-78.593 -78.593)"/></svg>
                        </div>
                    </button>
                </div>
                <div class="button-spacer-large">&nbsp;</div>
                <div id="naviagte-zoom-actual-size" class="action-button" title="Actual"
                     ng-click="appCtrl.serviceProvider.graphControlsCtrl.navigateCtrl.zoomActualSize();">
                    <button style="background-color: #FFFFFF">
                        <div class="graph-control-action-icon icon icon-zoom-actual"><svg xmlns="http://www.w3.org/2000/svg" width="17" height="19" viewBox="0 0 17 19"><defs><style>.a{}</style></defs><g transform="translate(-551 -71)"><rect class="a" width="2" height="19" transform="translate(551 71)"/><rect class="a" width="2" height="19" transform="translate(566 71)"/><rect class="a" width="3" height="3" transform="translate(558 76)"/><rect class="a" width="3" height="3" transform="translate(558 83)"/></g></svg>
                        </div>
                    </button>
                </div>
                <%--                <div class="button-spacer-large">&nbsp;</div>--%>
                <%--                <div id="naviagte-leave-group" class="action-button right" title="Leave group"--%>
                <%--                     ng-if="appCtrl.serviceProvider.graphControlsCtrl.navigateCtrl.isNotRootGroup()"--%>
                <%--                     ng-click="appCtrl.serviceProvider.graphControlsCtrl.navigateCtrl.leaveGroup();">--%>
                <%--                    <button><div class="graph-control-action-icon fa fa-level-up"></div></button>--%>
                <%--                </div>--%>
                <div class="clear"></div>
            </div>
            <div id="birdseye" style="display: none"></div>
        </div>
    </div>
</div>
<div id="graph-control">
    <div id="operation-control" class="graph-control" style="border-radius: 6px;">
        <%--        <div class="graph-control-docked pointer fa fa-hand-o-up" title="Operate"--%>
        <%--             ng-click="appCtrl.serviceProvider.graphControlsCtrl.undock($event)">--%>
        <%--        </div>--%>
        <%--        <div class="graph-control-header-container hidden pointer"--%>
        <%--             ng-click="appCtrl.serviceProvider.graphControlsCtrl.expand($event)">--%>
        <%--            <div class="graph-control-header-icon fa fa-hand-o-up">--%>
        <%--            </div>--%>
        <%--            <div class="graph-control-header">Operate</div>--%>
        <%--            <div class="graph-control-header-action">--%>
        <%--                <div class="graph-control-expansion fa fa-plus-square-o pointer"></div>--%>
        <%--            </div>--%>
        <%--            <div class="clear"></div>--%>
        <%--        </div>--%>
        <div class="graph-control-content hidden">
            <%--            <div id="operation-context">--%>
            <%--                <div id="operation-context-logo">--%>
            <%--                    <i class="icon" ng-class="appCtrl.serviceProvider.graphControlsCtrl.getContextIcon()"></i>--%>
            <%--                </div>--%>
            <%--                <div id="operation-context-details-container">--%>
            <%--                    <div id="operation-context-name">{{appCtrl.serviceProvider.graphControlsCtrl.getContextName()}}</div>--%>
            <%--                    <div id="operation-context-type" ng-class="appCtrl.serviceProvider.graphControlsCtrl.hide()">{{appCtrl.serviceProvider.graphControlsCtrl.getContextType()}}</div>--%>
            <%--                </div>--%>
            <%--                <div class="clear"></div>--%>
            <%--                <div id="operation-context-id" ng-class="appCtrl.serviceProvider.graphControlsCtrl.hide()">{{appCtrl.serviceProvider.graphControlsCtrl.getContextId()}}</div>--%>
            <%--            </div>--%>
            <div id="operation-buttons">
                <div style="display: flex;flex-direction: column; font-size: 18px">
                    <div id="operate-configure" class="action-button" title="Configuration">
                        <button ng-click="appCtrl.serviceProvider.graphControlsCtrl.openConfigureOrDetailsView();"
                                ng-disabled="!(appCtrl.serviceProvider.graphControlsCtrl.canConfigureOrOpenDetails())">
                            <div class="graph-control-action-icon fa fa-gear"><svg xmlns="http://www.w3.org/2000/svg" width="15.696" height="15.685" viewBox="0 0 15.696 15.685"><defs><style>.a{}</style></defs><path class="a" d="M79.125,73.313,77.795,72.3a3.827,3.827,0,0,0,0-.924l1.33-1.008a.907.907,0,0,0,.224-1.19l-1.484-2.507a.958.958,0,0,0-.826-.476.868.868,0,0,0-.322.056l-1.582.616a5.372,5.372,0,0,0-.826-.462L74.07,64.8a.938.938,0,0,0-.938-.8h-3a.938.938,0,0,0-.938.784l-.224,1.625a6.119,6.119,0,0,0-.826.462l-1.582-.616a.942.942,0,0,0-.336-.056.907.907,0,0,0-.812.462l-1.5,2.521a.913.913,0,0,0,.224,1.19l1.33,1.008c-.014.168-.028.322-.028.462a2.72,2.72,0,0,0,.028.462l-1.33,1.008a.907.907,0,0,0-.224,1.19L65.4,77.01a.958.958,0,0,0,.826.476.868.868,0,0,0,.322-.056l1.583-.616a5.371,5.371,0,0,0,.826.462l.238,1.611a.939.939,0,0,0,.938.8h3a.938.938,0,0,0,.938-.784l.238-1.625a6.118,6.118,0,0,0,.826-.462l1.583.616a.942.942,0,0,0,.336.056.907.907,0,0,0,.812-.462l1.5-2.535A.911.911,0,0,0,79.125,73.313Zm-4.131-1.47a3.361,3.361,0,1,1-3.361-3.361A3.371,3.371,0,0,1,74.994,71.842Z" transform="translate(-63.787 -64)"/></svg></div>
                        </button>
                    </div>
                    <div class="button-spacer-small" ng-if="appCtrl.nf.CanvasUtils.isManagedAuthorizer()">&nbsp;</div>
                    <div id="operate-policy" class="action-button" title="Access Policies"
                         ng-if="appCtrl.nf.CanvasUtils.isManagedAuthorizer()">
                        <button ng-click="appCtrl.nf.Actions['managePolicies'](appCtrl.nf.CanvasUtils.getSelection());"
                                ng-disabled="!(appCtrl.nf.CanvasUtils.canManagePolicies())">
                            <div class="graph-control-action-icon fa fa-key"><img class="icon-nifi-home-2"
                                                                                  src="images/Access Policies.svg">
                            </div>
                        </button>
                    </div>
                    <div class="button-spacer-large">&nbsp;</div>
                    <div id="operate-enable" class="action-button" title="Enable">
                        <button ng-click="appCtrl.nf.Actions['enable'](appCtrl.nf.CanvasUtils.getSelection());"
                                ng-disabled="!appCtrl.nf.CanvasUtils.getSelection().empty() && !appCtrl.nf.CanvasUtils.canModify(appCtrl.nf.CanvasUtils.getSelection());">
                            <div class="graph-control-action-icon fa fa-flash"><svg xmlns="http://www.w3.org/2000/svg" width="12.431" height="16.989" viewBox="0 0 12.431 16.989"><defs><style>.a{}</style></defs><path class="a" d="M195.955,84.61h-3.336a.621.621,0,0,1-.581-.843l3.315-8.7a.622.622,0,0,1,.581-.4h5.593a.621.621,0,0,1,.576.856l-1.93,4.737h3.633a.621.621,0,0,1,.467,1.031l-8.908,10.15a.621.621,0,0,1-1.068-.569l1.658-6.263Z" transform="translate(-191.997 -74.667)"/></svg></div>
                        </button>
                    </div>
                    <div class="button-spacer-large">&nbsp;</div>
                    <div id="operate-disable" class="action-button" title="Disable">
                        <button ng-click="appCtrl.nf.Actions['disable'](appCtrl.nf.CanvasUtils.getSelection());"
                                ng-disabled="!appCtrl.nf.CanvasUtils.getSelection().empty() && !appCtrl.nf.CanvasUtils.canModify(appCtrl.nf.CanvasUtils.getSelection());">
                            <div class="graph-control-action-icon icon icon-enable-false"><svg xmlns="http://www.w3.org/2000/svg" width="12.431" height="16.989" viewBox="0 0 12.431 16.989"><defs><style>.a{}</style></defs><g transform="translate(-164 -460)"><path class="a" d="M-765.091,1714.989a.646.646,0,0,1-.508-.251.6.6,0,0,1-.1-.533l1.658-6.263h-3.335a.613.613,0,0,1-.512-.269.612.612,0,0,1-.068-.573l2.264-5.943,6.128,7.844-5.066,5.773A.606.606,0,0,1-765.091,1714.989Zm6.2-6.752h0l-6.383-8.17.635-1.666a.625.625,0,0,1,.581-.4h5.593a.621.621,0,0,1,.516.274.621.621,0,0,1,.06.581l-1.93,4.737h3.632a.615.615,0,0,1,.566.365.615.615,0,0,1-.1.666l-3.169,3.612Z" transform="translate(932 -1238)"/><rect class="a" width="17" height="1" transform="translate(165.045 461.401) rotate(52)"/></g></svg>
                            </div>
                        </button>
                    </div>
                    <div class="button-spacer-large">&nbsp;</div>
                    <div id="operate-start" class="action-button" title="Start">
                        <button ng-click="appCtrl.nf.Actions['start'](appCtrl.nf.CanvasUtils.getSelection());"
                                ng-disabled="!appCtrl.nf.CanvasUtils.getSelection().empty() && !appCtrl.nf.CanvasUtils.canModify(appCtrl.nf.CanvasUtils.getSelection());">
                            <div class="graph-control-action-icon fa fa-play"><svg xmlns="http://www.w3.org/2000/svg" width="12.035" height="16.327" viewBox="0 0 12.035 16.327"><defs><style>.a{}</style></defs><path class="a" d="M418.055,319.091A1.294,1.294,0,0,0,416,320.138v13.74a1.294,1.294,0,0,0,2.055,1.046l9.446-6.87a1.294,1.294,0,0,0,0-2.094Z" transform="translate(-416 -318.843)"/></svg></div>
                        </button>
                    </div>
                    <div class="button-spacer-large">&nbsp;</div>
                    <div id="operate-stop" class="action-button" title="Stop">
                        <button ng-click="appCtrl.nf.Actions['stop'](appCtrl.nf.CanvasUtils.getSelection());"
                                ng-disabled="!appCtrl.nf.CanvasUtils.getSelection().empty() && !appCtrl.nf.CanvasUtils.canModify(appCtrl.nf.CanvasUtils.getSelection());">
                            <div class="graph-control-action-icon fa fa-stop"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><defs><style>.a{}</style></defs><rect class="a" width="16" height="16" rx="2"/></svg></div>
                        </button>
                    </div>
                    <div class="button-spacer-large">&nbsp;</div>
                    <div id="operate-copy" class="action-button" title="Copy">
                        <button ng-click="appCtrl.nf.Actions['copy'](appCtrl.nf.CanvasUtils.getSelection());"
                                ng-disabled="!appCtrl.nf.CanvasUtils.isCopyable(appCtrl.nf.CanvasUtils.getSelection());">
                            <div class="graph-control-action-icon fa fa-copy"><svg xmlns="http://www.w3.org/2000/svg" width="16.334" height="17.466" viewBox="0 0 16.334 17.466"><defs><style>.a{}</style></defs><path class="a" d="M14.4,3.274a1.892,1.892,0,0,1,.932.226,2.674,2.674,0,0,1,.705.557,2.471,2.471,0,0,1,.453.714,1.828,1.828,0,0,1,.157.679v9.839a2,2,0,0,1-.2.906,2.168,2.168,0,0,1-.522.679,2.475,2.475,0,0,1-.723.435,2.184,2.184,0,0,1-.8.157H5.819a1.661,1.661,0,0,1-.723-.192,3.054,3.054,0,0,1-.731-.505,2.862,2.862,0,0,1-.566-.723,1.693,1.693,0,0,1-.226-.827V5.52a1.861,1.861,0,0,1,.174-.758A3.023,3.023,0,0,1,4.2,4.04a2.528,2.528,0,0,1,.644-.549,1.476,1.476,0,0,1,.766-.218H14.4ZM13.377,14.158a1.071,1.071,0,0,0,.775-.313,1.028,1.028,0,0,0,.322-.766,1.1,1.1,0,0,0-1.1-1.1H6.847a1.1,1.1,0,0,0-1.1,1.1,1.028,1.028,0,0,0,.322.766,1.071,1.071,0,0,0,.775.313Zm0-4.353a1.071,1.071,0,0,0,.775-.313,1.028,1.028,0,0,0,.322-.766,1.1,1.1,0,0,0-1.1-1.1H6.847a1.1,1.1,0,0,0-1.1,1.1,1.028,1.028,0,0,0,.322.766,1.071,1.071,0,0,0,.775.313ZM16.459,0a2.329,2.329,0,0,1,1.376.444,4.545,4.545,0,0,1,1.088,1.1,5.589,5.589,0,0,1,.723,1.411,4.282,4.282,0,0,1,.261,1.384v9.247a1.128,1.128,0,0,1-.218.67,2.163,2.163,0,0,1-.531.522,2.888,2.888,0,0,1-.679.348,2.029,2.029,0,0,1-.679.131h-.07V4.858a3.135,3.135,0,0,0-.749-1.846,2.9,2.9,0,0,0-1.619-.836h-8.5a.3.3,0,0,0,.017-.122,1.435,1.435,0,0,1,.209-.714A2.565,2.565,0,0,1,7.639.679,3.131,3.131,0,0,1,8.4.192,1.991,1.991,0,0,1,9.233,0h7.227Z" transform="translate(-3.573)"/></svg></div>
                        </button>
                    </div>
                    <div class="button-spacer-large">&nbsp;</div>
                    <div id="operate-paste" class="action-button" title="Paste">
                        <button ng-click="appCtrl.nf.Actions['paste'](appCtrl.nf.CanvasUtils.getSelection());"
                                ng-disabled="!appCtrl.nf.CanvasUtils.isPastable()">
                            <div class="graph-control-action-icon fa fa-paste"><svg xmlns="http://www.w3.org/2000/svg" width="14.825" height="18.525" viewBox="0 0 14.825 18.525"><defs><style>.a{}</style></defs><path class="a" d="M139.3,70.232l3.523,3.65h-3.706v-3.65Zm2.288-3.22V68.92h-1.081l-1.39.021h-8.647V81.294h-1.93a.543.543,0,0,1-.541-.541V67.012a.543.543,0,0,1,.541-.541h4.4v-1.39A1.085,1.085,0,0,1,134.022,64h1.39a1.084,1.084,0,0,1,1.081,1.081v1.39h4.555A.542.542,0,0,1,141.589,67.012Zm-6.174-1.928s0,0,0,0h-1.387l0,0v1.387h1.392Zm2.468,5.149h-5.575a.558.558,0,0,0-.6.54V81.984a.543.543,0,0,0,.541.541h10.037a.543.543,0,0,0,.541-.541V75.172h-4.941v-4.94Zm1.418,0,3.523,3.65h-3.706v-3.65Z" transform="translate(-128 -64)"/></svg></div>
                        </button>
                    </div>
                    <div class="button-spacer-large">&nbsp;</div>
                    <div id="operate-group" class="action-button" title="Group">
                        <button ng-click="appCtrl.nf.Actions['group'](appCtrl.nf.CanvasUtils.getSelection());"
                                ng-disabled="!(appCtrl.nf.CanvasUtils.getComponentByType('Connection').isDisconnected(appCtrl.nf.CanvasUtils.getSelection()) && appCtrl.nf.CanvasUtils.canModify(appCtrl.nf.CanvasUtils.getSelection()));">
                            <div class="graph-control-action-icon icon icon-group"><svg xmlns="http://www.w3.org/2000/svg" width="18.563" height="18.563" viewBox="0 0 18.563 18.563"><defs><style>.a{}</style></defs><path class="a" d="M18.563,5.1V0H13.494V2.019H5.068V0H0V5.1H2.006v8.363H0v5.1H5.068V16.544h8.426v2.019h5.068v-5.1H16.556V5.1ZM15.5,13.463H13.494v2.019H5.068V13.463H3.062V5.1H5.068V3.081h8.426V5.1H15.5v8.363Z"/></svg></div>
                        </button>
                    </div>
                    <div class="button-spacer-large">&nbsp;</div>
                    <div id="operate-color" class="action-button" title="Change Color">
                        <button ng-click="appCtrl.nf.Actions['fillColor'](appCtrl.nf.CanvasUtils.getSelection());"
                                ng-disabled="!appCtrl.nf.CanvasUtils.isColorable(appCtrl.nf.CanvasUtils.getSelection());">
                            <div class="graph-control-action-icon fa fa-paint-brush"><svg xmlns="http://www.w3.org/2000/svg" width="17.818" height="17.562" viewBox="0 0 17.818 17.562"><defs><style>.a{}</style></defs><path class="a" d="M166.012,176.7s-2.309,1.254-2.4,3.219a4.515,4.515,0,0,1-2.591,3.573c-.625.179,9.141.583,8.427-3.615l-3.438-3.177Zm4.292,1.334a.674.674,0,1,1-.886.913l-2.355-2.247a.674.674,0,1,1,.886-.913l2.355,2.247Zm8.166-11.8a1.27,1.27,0,0,0-1.459.1c-.739.495-6.022,5.629-8.317,8-.282.376-.472.667.88,2.019,1.141,1.141,1.673,1.066,2.25.574.962-.962,5.059-6.673,6.572-8.851C178.645,167.711,179.154,166.693,178.47,166.23Z" transform="translate(-160.995 -166.031)"/></svg>
                            </div>
                        </button>
                    </div>
                    <div class="button-spacer-large">&nbsp;</div>
                    <div id="operate-delete" class="action-button" title="Delete">
                        <button ng-click="appCtrl.nf.Actions['delete'](appCtrl.nf.CanvasUtils.getSelection());"
                                ng-disabled="!appCtrl.nf.CanvasUtils.areDeletable(appCtrl.nf.CanvasUtils.getSelection());">
                            <div class="graph-control-action-icon fa fa-trash"><svg xmlns="http://www.w3.org/2000/svg" width="13.131" height="15.756" viewBox="0 0 13.131 15.756"><defs><style>.a{}</style></defs><path class="a" d="M169.671,103.969a.818.818,0,0,1,.821-.815h4.1v-.814a.817.817,0,0,1,.821-.814h1.642a.818.818,0,0,1,.821.816v.815h4.1a.819.819,0,0,1,.821.816v.815H169.671v-.818Zm12.31,2.444v10.051a.819.819,0,0,1-.821.816h-9.848a.818.818,0,0,1-.821-.816V105.6h11.49v.813Zm-8.207,1.631a.82.82,0,0,0-1.641,0v6.792a.821.821,0,0,0,1.642,0v-6.792Zm3.283,0a.821.821,0,0,0-1.642,0v6.792a.821.821,0,0,0,1.642,0v-6.792Zm3.282,0a.821.821,0,0,0-1.642,0v6.792a.821.821,0,0,0,1.642,0v-6.792Z" transform="translate(-169.671 -101.525)"/></svg></div>
                        </button>
                    </div>
                    <div class="clear"></div>
                </div>
                <%--                <div style="margin-top: 5px;">--%>
                <%--                    <div id="operate-copy" class="action-button" title="Copy">--%>
                <%--                        <button ng-click="appCtrl.nf.Actions['copy'](appCtrl.nf.CanvasUtils.getSelection());"--%>
                <%--                                ng-disabled="!appCtrl.nf.CanvasUtils.isCopyable(appCtrl.nf.CanvasUtils.getSelection());">--%>
                <%--                            <div class="graph-control-action-icon fa fa-copy"></div></button>--%>
                <%--                    </div>--%>
                <%--                    <div class="button-spacer-small">&nbsp;</div>--%>
                <%--                    <div id="operate-paste" class="action-button" title="Paste">--%>
                <%--                        <button ng-click="appCtrl.nf.Actions['paste'](appCtrl.nf.CanvasUtils.getSelection());"--%>
                <%--                                ng-disabled="!appCtrl.nf.CanvasUtils.isPastable()">--%>
                <%--                            <div class="graph-control-action-icon fa fa-paste"></div></button>--%>
                <%--                    </div>--%>
                <%--                    <div class="button-spacer-large">&nbsp;</div>--%>
                <%--                    <div id="operate-group" class="action-button" title="Group">--%>
                <%--                        <button ng-click="appCtrl.nf.Actions['group'](appCtrl.nf.CanvasUtils.getSelection());"--%>
                <%--                                ng-disabled="!(appCtrl.nf.CanvasUtils.getComponentByType('Connection').isDisconnected(appCtrl.nf.CanvasUtils.getSelection()) && appCtrl.nf.CanvasUtils.canModify(appCtrl.nf.CanvasUtils.getSelection()));">--%>
                <%--                            <div class="graph-control-action-icon icon icon-group"></div></button>--%>
                <%--                    </div>--%>
                <%--                    <div class="button-spacer-large">&nbsp;</div>--%>
                <%--                    <div id="operate-color" class="action-button" title="Change Color">--%>
                <%--                        <button ng-click="appCtrl.nf.Actions['fillColor'](appCtrl.nf.CanvasUtils.getSelection());"--%>
                <%--                                ng-disabled="!appCtrl.nf.CanvasUtils.isColorable(appCtrl.nf.CanvasUtils.getSelection());">--%>
                <%--                            <div class="graph-control-action-icon fa fa-paint-brush"></div></button>--%>
                <%--                    </div>--%>
                <%--                    <div class="button-spacer-large">&nbsp;</div>--%>
                <%--                    <div id="operate-delete" class="action-button" title="Delete">--%>
                <%--                        <button ng-click="appCtrl.nf.Actions['delete'](appCtrl.nf.CanvasUtils.getSelection());"--%>
                <%--                                ng-disabled="!appCtrl.nf.CanvasUtils.areDeletable(appCtrl.nf.CanvasUtils.getSelection());">--%>
                <%--                            <div class="graph-control-action-icon fa fa-trash"></div><span>Delete</span></button>--%>
                <%--                    </div>--%>
                <%--                    <div class="clear"></div>--%>
                <%--                </div>--%>
            </div>
        </div>
    </div>
</div>