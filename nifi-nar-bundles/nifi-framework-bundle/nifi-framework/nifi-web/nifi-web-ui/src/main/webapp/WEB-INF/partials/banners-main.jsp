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
<div id="banner-header" class="main-banner-header"></div>
<div id="banner-footer" class="main-banner-footer"></div>

<div id="flow-status" flex layout="row" layout-align="space-between center">
    <div id="flow-status-container" layout="row" layout-align="space-around center">
        <div  ng-if="appCtrl.nf.ClusterSummary.isClustered()" ng-class="appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.getExtraClusterStyles()"
             title="Connected nodes / Total number of nodes in the cluster">
            <span id="connected-nodes-count"></span>
        </div>
        <div ng-class="appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.getExtraThreadStyles()"
             title="Active Threads{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.hasTerminatedThreads() ? ' (Terminated)' : ''}}">
            <span id="active-thread-count"></span>
        </div>
        <div title="Total queued data">
            <span id="total-queued"></span>
        </div>
        <div title="Transmitting Remote Process Groups">
            <span id="controller-transmitting-count"></span>
        </div>
        <div title="Not Transmitting Remote Process Groups">
            <span id="controller-not-transmitting-count"></span>
        </div>
        <div title="Running Components">
            <span id="controller-running-count"></span>
        </div>
        <div title="Stopped Components">
            <span id="controller-stopped-count"></span>
        </div>
        <div title="Invalid Components">
            <span id="controller-invalid-count"></span>
        </div>
        <div title="Disabled Components">
            <span id="controller-disabled-count"></span>
        </div>
        <div title="Up to date Versioned Process Groups">
            <span id="controller-up-to-date-count"></span>
        </div>
        <div title="Locally modified Versioned Process Groups">
            <span id="controller-locally-modified-count"></span>
        </div>
        <div title="Stale Versioned Process Groups">
            <span id="controller-stale-count"></span>
        </div>
        <div title="Locally modified and stale Versioned Process Groups">
            <span id="controller-locally-modified-and-stale-count"></span>
        </div>
        <div title="Sync failure Versioned Process Groups">
            <span id="controller-sync-failure-count"></span>
        </div>
        <div id="canvas-loading-container" class="loading-container"></div>
    </div>
    <button id="theme-toggle" ng-click="appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.search.themeToggle();"><img class="icon-nifi-home-1-1" src="images/ms-yl.svg"></button>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <div layout="row" class="search" layout-align="end center">
        <span>
        <svg t="1700794509320" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2609" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"><path d="M921.3 874L738.1 690.8c51.3-62.6 82.1-142.5 82.1-229.6 0-200.1-162.8-363-363-363-200.1 0-363 162.8-363 363s162.8 363 363 363c87 0 167-30.8 229.6-82.1L870 925.3c7.1 7.1 16.4 10.6 25.7 10.6s18.6-3.5 25.7-10.6c14.1-14.2 14.1-37.2-0.1-51.3zM166.8 461.2c0-160.1 130.3-290.4 290.4-290.4s290.4 130.3 290.4 290.4-130.3 290.4-290.4 290.4-290.4-130.3-290.4-290.4z" p-id="2610"></path></svg>
        </span>
        <input id="search-field" type="text" placeholder="Search" style="display: block !important;"/>
    </div>
    <div layout="row" layout-align="end center">
<%--        <div id="search-container">--%>
<%--            <button id="search-button" ng-click="appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.search.toggleSearchField();"><i class="fa fa-search">--%>
<%--                <?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"><svg t="1700794509320" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2609" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"><path d="M921.3 874L738.1 690.8c51.3-62.6 82.1-142.5 82.1-229.6 0-200.1-162.8-363-363-363-200.1 0-363 162.8-363 363s162.8 363 363 363c87 0 167-30.8 229.6-82.1L870 925.3c7.1 7.1 16.4 10.6 25.7 10.6s18.6-3.5 25.7-10.6c14.1-14.2 14.1-37.2-0.1-51.3zM166.8 461.2c0-160.1 130.3-290.4 290.4-290.4s290.4 130.3 290.4 290.4-130.3 290.4-290.4 290.4-290.4-130.3-290.4-290.4z" p-id="2610"></path></svg>--%>
<%--            </i></button>--%>
<%--            <input id="search-field" type="text" placeholder="Search" style="border-radius: 11px"/>--%>
<%--        </div>--%>
        <div layout-align="space-between end" layout="column" class="space-between">
            <div layout="column" layout-align="space-between center" id="current-user-container">
<%--                <span id="anonymous-user-alert" class="hidden fa fa-warning"></span>--%>
                <div></div>
                <div id="current-user"></div>
            </div>
            <div id="login-link-container" id="aa">
                    <span id="login-link" class="link"
                          ng-click="appCtrl.serviceProvider.headerCtrl.loginCtrl.shell.launch();">log in</span>
            </div>
            <div id="logout-link-container" class="aa" style="display: none;">
                    <span id="logout-link" class="link"
                          ng-click="appCtrl.serviceProvider.headerCtrl.logoutCtrl.logout();">log out</span>
            </div>
        </div>
        <button id="bulletin-button"><i class="fa fa-user"><img class="icon-nifi-home-1" src="images/? 157.svg"></i></button>
    </div>
</div>
<div id="search-flow-results"></div>
