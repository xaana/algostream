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
<div id="flow-status2" flex layout="column" layout-align="space-between center aa">
    <%--    <div id="flow-status-container" layout="column" layout-align="space-around center">--%>
    <div class="fa fa-cubes blue-border" ng-if="appCtrl.nf.ClusterSummary.isClustered()"
         ng-class="appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.getExtraClusterStyles()"
         title="Connected nodes / Total number of nodes in the cluster" style="font-size: x-small; padding-left: 5px;">
        <span id="connected-nodes-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.connectedNodesCount}}</span>
    </div>
    <div class="icon icon-threads blue-border"
         title="Active Threads{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.hasTerminatedThreads() ? ' (Terminated)' : ''}}"
         style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2">
            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"
                 viewBox="0 0 20 20">
                <defs>
                    <style>.a, .d {
                    }

                    .a {
                    }

                    .b {
                        clip-path: url(#a);
                    }

                    .c, .f {
                    }

                    .c {
                    }

                    .e {
                    }</style>
                    <clipPath id="a">
                        <rect class="a" width="20" height="20" transform="translate(79 8)"/>
                    </clipPath>
                </defs>
                <g class="b" transform="translate(-79 -8)">
                    <g transform="translate(1 -54)">
                        <g class="c" transform="translate(81 64.4)">
                            <circle class="e" cx="2" cy="2" r="2"/>
                            <circle class="f" cx="2" cy="2" r="1.5"/>
                        </g>
                        <circle class="d" cx="2" cy="2" r="2" transform="translate(86 64.4)"/>
                        <circle class="d" cx="2" cy="2" r="2" transform="translate(86 69.254)"/>
                        <circle class="d" cx="2" cy="2" r="2" transform="translate(86 74.6)"/>
                        <circle class="d" cx="2" cy="2" r="2" transform="translate(91 74.6)"/>
                        <circle class="d" cx="2" cy="2" r="2" transform="translate(81 69.25)"/>
                        <g class="c" transform="translate(91 64.4)">
                            <circle class="e" cx="2" cy="2" r="2"/>
                            <circle class="f" cx="2" cy="2" r="1.5"/>
                        </g>
                        <g class="c" transform="translate(91 69.25)">
                            <circle class="e" cx="2" cy="2" r="2"/>
                            <circle class="f" cx="2" cy="2" r="1.5"/>
                        </g>
                        <g class="c" transform="translate(81 74.6)">
                            <circle class="e" cx="2" cy="2" r="2"/>
                            <circle class="f" cx="2" cy="2" r="1.5"/>
                        </g>
                    </g>
                </g>
            </svg>
        </div>
        <span id="active-thread-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.threadCounts}}</span>
    </div>
    <div class="fa fa-list blue-border" title="Total queued data" style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700616878318" class="icon" viewBox="0 0 1305 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="17574" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M0.837818 75.218317c0 19.642164 8.098902 39.191237 21.969435 53.06177 13.963624 13.963624 33.512697 22.062525 53.247951 22.062525a76.055204 76.055204 0 0 0 53.06177-21.969434c13.963624-13.963624 22.062525-33.512697 22.062526-53.154861A76.055204 76.055204 0 0 0 129.303156 21.970365 76.055204 76.055204 0 0 0 76.055204 0.000931a76.055204 76.055204 0 0 0-53.247951 21.969434A76.706839 76.706839 0 0 0 0.837818 75.218317M0.837818 476.160498c0 19.642164 8.005811 39.377419 21.969435 53.247952 13.963624 13.963624 33.419606 21.969435 53.247951 21.969434a76.241385 76.241385 0 0 0 53.154861-21.969434 75.962113 75.962113 0 0 0 21.969435-53.247952 76.241385 76.241385 0 0 0-21.969435-53.154861 75.962113 75.962113 0 0 0-53.154861-21.969434 76.241385 76.241385 0 0 0-53.247951 21.969434 75.962113 75.962113 0 0 0-21.969435 53.154861M0.837818 877.19577c0 19.642164 8.005811 39.284328 21.969435 53.247951 13.963624 13.963624 33.419606 21.969435 53.247951 21.969435a76.241385 76.241385 0 0 0 53.154861-21.969435 75.962113 75.962113 0 0 0 21.969435-53.247951 76.241385 76.241385 0 0 0-21.969435-53.247952 75.962113 75.962113 0 0 0-53.154861-21.969434 76.241385 76.241385 0 0 0-53.247951 21.969434 76.520658 76.520658 0 0 0-21.969435 53.247952M1304.109361 75.218317c0 41.518508-32.395607 75.124295-72.331571 75.124295H373.945843c-40.029055 0-72.331571-33.512697-72.331571-75.124295C301.521181 33.513628 333.916788 0.000931 373.945843 0.000931h857.831947c40.029055 0 72.331571 33.605788 72.331571 75.217386M1231.77779 551.377884H373.945843c-40.029055 0-72.331571-33.605788-72.331571-75.217386 0-41.518508 32.302516-75.124295 72.331571-75.124295h857.831947c40.029055-0.186182 72.331571 33.512697 72.331571 75.124295 0 41.425417-32.395607 75.217386-72.331571 75.217386zM1304.109361 877.102679c0 41.611599-32.395607 75.310477-72.331571 75.310477H373.945843c-40.029055 0-72.331571-33.698878-72.331571-75.310477 0-41.425417 32.302516-75.124295 72.331571-75.124295h857.831947c40.029055-0.093091 72.331571 33.698878 72.331571 75.124295"
                      p-id="17575"></path>
            </svg>
        </div>
        <span id="total-queued"
              class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.totalQueued}}</span>
    </div>
    <div class="fa fa-bullseye blue-border" title="Transmitting Remote Process Groups"
         style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700548130267" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="21304" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M1022.464 619.008c-9.216-72.192-51.2-136.704-113.664-172.032-18.432-166.912-157.696-294.912-327.168-296.96-111.616 0-216.064 55.808-276.48 151.04-72.192-2.56-141.824 18.432-199.68 60.416-25.6 16.384-44.032 39.424-60.416 65.024-55.808 90.624-57.856 204.288-7.168 296.96 48.64 86.016 136.704 141.824 234.496 146.432h545.28c125.952-14.336 219.136-125.44 204.8-250.88z m-731.136-18.432c16.384-11.776 37.376-11.776 48.64 0l9.216 9.216V477.184c0-18.432 16.384-34.816 34.816-34.816 18.432 0 34.816 16.384 34.816 34.816V609.28l9.216-9.216c13.824-13.824 34.816-13.824 48.64 0s13.824 34.816 0 48.64l-53.248 53.248c-23.04 23.04-60.416 23.04-81.408 0l-53.248-53.248c-13.824-13.312-11.264-36.864 2.56-48.128z m302.08-39.424c-13.824 13.824-37.376 11.776-48.64-2.56-11.776-13.824-11.776-34.816 0-46.592l53.248-53.248c20.992-20.992 57.856-20.992 81.408 2.56l53.248 53.248c13.824 13.824 13.824 34.816 0 48.64-7.168 7.168-16.384 9.216-25.6 9.216-9.216 0-18.432-4.608-25.6-9.216l-9.216-9.216v130.048c0 18.432-16.384 34.816-34.816 34.816-18.432 0-34.816-16.384-34.816-34.816v-132.096l-9.216 9.216z"
                      p-id="21305"></path>
            </svg>
        </div>
        <span id="controller-transmitting-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerTransmittingCount}}</span>
    </div>
    <div class="icon icon-transmit-false blue-border" title="Not Transmitting Remote Process Groups"
         style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700549797457" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="49604" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M512 70.9c-243.36 0-438.92 195.56-438.92 438.92S268.64 953.1 512 953.1s438.92-195.56 438.92-438.92C950.92 266.47 755.36 70.9 512 70.9z m0 838.74c-221.63 0-399.81-178.17-399.81-399.81 0-104.3 39.11-195.56 104.3-269.44l564.95 564.95C707.56 870.52 616.3 909.64 512 909.64z m295.51-130.38L242.56 214.31C312.09 149.12 407.7 110.02 512 110.02c221.63 0 399.81 178.17 399.81 399.81 0 104.3-39.11 199.9-104.3 269.43z m0 0"
                      p-id="49605"></path>
                <path d="M504.16 379.46a10.783 10.783 0 0 1 15.6 0l119.31 123c6.71 6.87 1.76 18.44-7.8 18.44h-60.5l202.01 202.01c51.63-22.68 87.05-75.1 87.05-137.45 0.08-77.72-60.79-143.54-133.32-149.5-20.29-101.7-107.32-179.43-214.56-179.43-57.05 0-108.73 22.04-146.93 58.61l102.29 102.29 36.85-37.97zM569.98 629.65c0 6.04-4.86 10.9-10.9 10.9h-94.24c-6.03 0-10.9-4.86-10.9-10.9V520.9h-61.29c-9.64 0-14.51-11.57-7.8-18.44l37.13-38.28-96.81-96.81c-1.58 2.9-3.09 5.84-4.54 8.82-87.81 11.62-153.41 83.16-156.5 172.81v13.08c3.33 95.72 80.28 172.88 173.85 172.88h354.78L569.98 612.17v17.48z"
                      p-id="49606"></path>
            </svg>
        </div>
        <span id="controller-not-transmitting-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerNotTransmittingCount}}</span>
    </div>
    <div class="fa fa-play blue-border" title="Running Components" style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700550019345" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="50712" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M510.9 60.7c-245.6 0-446.7 199.8-446.7 446.7C64.2 753 263.9 954 510.8 954s446.6-199.7 446.6-446.6c0.1-245.6-199.6-446.7-446.5-446.7zM692 525.9l-272.1 157c-10.7 6.2-24-1.5-24-13.9V354.9c0-12.3 13.3-20 24-13.9L692 498.1c10.6 6.2 10.6 21.6 0 27.8z"
                      p-id="50713"></path>
            </svg>
        </div>
        <span id="controller-running-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerRunningCount}}</span>
    </div>
    <div class="fa fa-stop blue-border" title="Stopped Components" style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700550030503" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="51673" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M510.9 60.7c-245.6 0-446.7 199.8-446.7 446.7C64.2 753 263.9 954 510.8 954s446.6-199.7 446.6-446.6c0.1-245.6-199.6-446.7-446.5-446.7z m139.8 574c0 8.8-7.2 16-16 16H389.3c-8.8 0-16-7.2-16-16V389.3c0-8.8 7.2-16 16-16h245.5c8.8 0 16 7.2 16 16v245.4z"
                      p-id="51674"></path>
            </svg>
        </div>
        <span id="controller-stopped-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerStoppedCount}}</span>
    </div>
    <div class="fa fa-warning blue-border" title="Invalid Components" style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700550232327" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="52643" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M1006.4 876.4 585.6 64.128c-40.464-78.128-106.72-78.128-147.184 0L17.6 876.4c-40.464 78.128-1.6 142.064 86.4 142.064l816 0C1008 1018.464 1046.88 954.528 1006.4 876.4zM460.816 313.168c0-28.256 22.912-51.184 51.184-51.184s51.216 22.944 51.216 51.184l0 345.632c0 28.256-22.944 51.184-51.216 51.184s-51.184-22.944-51.184-51.184L460.816 313.168zM512 905.168c-35.344 0-64-28.624-64-64 0-35.344 28.656-64 64-64s64 28.656 64 64C576 876.544 547.344 905.168 512 905.168z"
                      p-id="52644"></path>
            </svg>
        </div>
        <span id="controller-invalid-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerInvalidCount}}</span>
    </div>
    <div class="icon icon-enable-false blue-border" title="Disabled Components"
         style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700550369022" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="61828" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M795.59695994 228.40304006C638.71353519 71.5196153 385.28646481 71.5196153 228.40304006 228.40304006c-76.93321779 76.93321779-116.15407345 176.49385258-116.15407416 279.07147654-1.50849423 1.50849423 0 3.01698846-1.50849353 4.5254834 0 3.01698846 0 3.01698846 1.50849353 4.5254834 1.50849423 101.06912902 39.22085637 202.13825875 116.15407416 279.07147654 156.88342475 156.88342475 410.31049513 156.88342475 567.19391988 0S952.4803847 385.28646481 795.59695994 228.40304006z m-40.72935059 40.72935059c60.33977843 60.33977843 93.52665645 135.76450199 99.56063479 214.20621472L169.57175586 483.33860537C177.11422843 406.40538687 208.79261223 329.47216908 269.13239065 269.13239065c134.25600776-134.25600776 351.47921094-134.25600776 485.7352187 0z m-485.7352187 485.7352187c-60.33977843-60.33977843-93.52665645-135.76450199-99.56063479-214.20621472l681.83949911 7.1e-7c-6.03397763 78.44171202-39.22085566 153.86643559-99.56063479 214.2062133-131.23901859 134.25600705-348.46222177 134.25600705-482.71822953 7.1e-7z"
                      p-id="61829"></path>
            </svg>
        </div>
        <span id="controller-disabled-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerDisabledCount}}</span>
    </div>
    <div class="fa fa-check blue-border" title="Up to date Versioned Process Groups"
         style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700550728648" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="85699" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M851.2 32H198.4c-38.4 0-64 25.6-64 64v844.8c0 32 32 64 64 64h409.6c38.4 0 64-25.6 64-64v-134.4c0-32 32-64 64-64h108.8c38.4 0 64-25.6 64-64V89.6c12.8-32-19.2-57.6-57.6-57.6zM640 556.8c0 19.2-12.8 32-32 32H320c-19.2 0-32-12.8-32-32v-6.4c0-19.2 12.8-32 32-32h288c19.2 0 32 12.8 32 38.4zM780.8 384c0 19.2-12.8 32-32 32H320c-19.2-6.4-38.4-19.2-38.4-32v-6.4c0-19.2 12.8-32 32-32h428.8c25.6 0 38.4 12.8 38.4 38.4z m0-172.8c0 19.2-12.8 32-32 32H320c-19.2 0-32-12.8-32-32v-6.4c0-19.2 12.8-32 32-32h428.8c19.2 0 32 12.8 32 38.4z"
                      p-id="85700"></path>
                <path d="M716.8 851.2v89.6c0 32 38.4 44.8 57.6 25.6l128-128c19.2-19.2 6.4-57.6-25.6-57.6h-89.6c-38.4 0-70.4 32-70.4 70.4z"
                      p-id="85701"></path>
            </svg>
        </div>
        <span id="controller-up-to-date-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerUpToDateCount}}</span>
    </div>
    <div class="fa fa-asterisk blue-border" title="Locally modified Versioned Process Groups"
         style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700551640889" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="89133" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M702.932 777.584c-11.692-3.161-23.743 3.758-26.903 15.45-3.165 11.698 3.758 23.744 15.451 26.903 73.027 19.747 105.712 47.546 105.712 66.333 0 14.494-19.804 37.052-75.398 56.907-55.701 19.895-130.205 30.845-209.791 30.845-79.586 0-154.099-10.95-209.799-30.845-55.593-19.855-75.396-42.413-75.396-56.907 0-18.793 32.702-46.602 105.761-66.348 11.698-3.161 18.618-15.201 15.456-26.899-3.159-11.692-15.199-18.617-26.897-15.455-89.119 24.084-138.198 62.687-138.198 108.702 0 26.869 17.359 47.165 31.924 59.459 17.477 14.762 41.905 27.805 72.594 38.766 60.318 21.541 140.063 33.407 224.549 33.407 84.493 0 164.238-11.872 224.556-33.407 30.689-10.961 55.115-24.005 72.595-38.766 14.564-12.295 31.924-32.59 31.924-59.459 0-46-49.056-84.603-138.137-108.686v0zM422.048 826.725c23.419 26.842 56.222 42.223 90.118 42.223h0.005c34.028 0 66.802-15.506 90.080-42.569 7.059-7.696 67.087-73.789 127.916-160.351 88.146-125.43 132.837-229.369 132.837-308.923 0-47.367-9.283-93.344-27.597-136.64-17.684-41.803-42.986-79.343-75.212-111.563-32.219-32.218-69.751-57.526-111.554-75.202-43.302-18.315-89.278-27.603-136.639-27.603-47.367 0-93.344 9.289-136.641 27.603-41.802 17.678-79.342 42.985-111.561 75.202-32.219 32.226-57.526 69.759-75.202 111.563-18.315 43.297-27.603 89.273-27.603 136.64 0 79.552 44.724 183.524 132.929 309.029 61.247 87.146 121.682 153.568 128.124 160.59v0zM375.908 347.29c0-77.421 62.989-140.405 140.402-140.405 77.421 0 140.404 62.986 140.404 140.405 0 77.415-62.982 140.404-140.404 140.404-77.414 0-140.402-62.989-140.402-140.404v0zM375.908 347.29z"
                      p-id="89134"></path>
            </svg>
        </div>
        <span id="controller-locally-modified-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerLocallyModifiedCount}}</span>
    </div>
    <div class="fa fa-arrow-circle-up blue-border" title="Stale Versioned Process Groups"
         style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700551750808" class="icon" viewBox="0 0 1025 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="90965" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M793.498 66c44.459 0 80.5 36.041 80.5 80.5L874 596.946c-20.863-7.371-43.314-11.382-66.702-11.382-110.512 0-200.1 89.547-200.1 200.009 0 73.447 39.608 137.648 98.637 172.427l-464.335-0.005c-44.459 0-80.5-36.041-80.5-80.5V146.5c0-44.459 36.041-80.5 80.5-80.5h551.998zM588.812 539.585H252.986c-16.506 0-29.886 13.38-29.886 29.886s13.38 29.887 29.886 29.887h335.826c16.506 0 29.887-13.381 29.887-29.887s-13.38-29.886-29.887-29.886z m193.2-160.927H252.986c-16.506 0-29.886 13.38-29.886 29.886s13.38 29.887 29.886 29.887h529.026c16.506 0 29.886-13.38 29.886-29.887 0-16.505-13.38-29.886-29.886-29.886z m-193.2-160.927H252.986c-16.506 0-29.886 13.38-29.886 29.886s13.38 29.887 29.886 29.887h335.826c16.506 0 29.887-13.38 29.887-29.887 0-16.505-13.38-29.886-29.887-29.886z"
                      p-id="90966"></path>
                <path d="M807.5 613c95.27 0 172.5 77.23 172.5 172.5S902.77 958 807.5 958 635 880.77 635 785.5 712.23 613 807.5 613z m15.365 78.2c-6.682 0-12.099 5.417-12.099 12.099v90.556l-64.15 63.379-0.098 0.097c-4.582 4.634-4.54 12.105 0.094 16.688 4.704 4.651 12.275 4.653 16.982 0.003l67.99-67.172 0.098-0.097a11.782 11.782 0 0 0 3.283-10.025l-0.001-93.43c0-6.681-5.417-12.098-12.099-12.098z"
                      p-id="90967"></path>
            </svg>
        </div>
        <span id="controller-stale-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerStaleCount}}</span>
    </div>
    <div class="fa fa-exclamation-circle blue-border" title="Locally modified and stale Versioned Process Groups"
         style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700551760679" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="91109" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M512 89.429333A422.570667 422.570667 0 1 0 934.570667 512 422.570667 422.570667 0 0 0 512 89.429333z m151.210667 573.781334a34.133333 34.133333 0 0 1-48.128 0l-127.317334-126.976A34.133333 34.133333 0 0 1 477.866667 512V257.706667a34.133333 34.133333 0 0 1 68.266666 0v238.933333L663.210667 614.4a34.133333 34.133333 0 0 1 0 48.810667z"
                      p-id="91110"></path>
            </svg>
        </div>
        <span id="controller-locally-modified-and-stale-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerLocallyModifiedAndStaleCount}}</span>
    </div>
    <div class="fa fa-question blue-border" title="Sync failure Versioned Process Groups"
         style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <svg t="1700795570099" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                 p-id="43167" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20">
                <path d="M67.584 140.288h744.96c3.072 0 3.584-4.096 1.024-4.608L708.096 102.4H195.584l-128.512 32.768c-3.072 1.024-2.56 5.12 0.512 5.12zM90.112 366.08h699.904c14.336 0 26.112-11.264 26.112-24.576V178.688c0-13.824-11.776-24.576-26.112-24.576H90.112c-14.336 0-26.112 11.264-26.112 24.576v162.816c-0.512 13.824 11.264 24.576 26.112 24.576zM662.016 230.4c17.408 0 31.744 13.312 31.744 29.696s-14.336 29.696-31.744 29.696c-17.408 0-31.744-13.312-31.744-29.696 0-16.384 14.336-29.696 31.744-29.696z m-99.84 0c17.408 0 31.744 13.312 31.744 29.696s-14.336 29.696-31.744 29.696c-17.408 0-31.744-13.312-31.744-29.696 0-16.384 14.336-29.696 31.744-29.696z m-377.344 2.048h176.64v55.808H184.832V232.448zM568.32 772.608c-2.048 0.512-3.584 0.512-5.632 0.512-17.408 0-31.744-13.312-31.744-29.696s14.336-29.696 31.744-29.696c1.024-26.624 6.144-52.224 15.36-76.288H90.112c-14.336 0-26.112 11.264-26.112 24.576v162.816c0 13.824 11.776 24.576 26.112 24.576h511.488c-15.36-23.04-26.624-48.64-33.28-76.8z m-206.848-1.024H184.832v-55.808h176.64v55.808zM661.504 531.456c-17.408-0.512-31.232-13.824-31.232-29.696 0-16.384 14.336-29.696 31.744-29.696 17.408 0 31.744 13.312 31.744 29.696 0 4.608-1.024 8.704-3.072 12.288 30.72-15.36 65.024-23.552 101.888-23.552 8.192 0 15.872 0.512 23.552 1.024V420.352c0-13.824-11.776-24.576-26.112-24.576H90.112c-14.336 0-26.112 11.264-26.112 24.576v162.816c0 13.824 11.776 24.576 26.112 24.576h501.76c17.408-30.208 40.96-56.32 69.632-76.288z m-300.032-1.536H184.832v-56.32h176.64v56.32z m169.472-28.16c0-16.384 14.336-29.696 31.744-29.696 17.408 0 31.744 13.312 31.744 29.696 0 16.384-14.336 29.696-31.744 29.696-17.92 0-31.744-13.312-31.744-29.696z"
                      p-id="43168"></path>
                <path d="M792.576 517.12c-113.152 0-204.8 91.648-204.8 204.8s91.648 204.8 204.8 204.8 204.8-91.648 204.8-204.8c0-112.64-91.648-204.8-204.8-204.8z m75.776 275.456c-8.192 8.192-21.504 8.704-29.696 1.024l-45.056-42.496-43.008 45.568c-8.192 8.192-21.504 8.704-29.696 1.024s-8.704-21.504-1.024-29.696l42.496-45.056-45.056-42.496c-8.192-8.192-8.704-21.504-1.024-29.696s21.504-8.704 29.696-1.024l45.056 42.496 42.496-45.056c8.192-8.192 21.504-8.704 29.696-1.024 8.192 7.168 8.192 20.992 1.536 28.672l-42.496 45.056 45.056 42.496c8.192 8.192 8.704 22.016 1.024 30.208z"
                      p-id="43169"></path>
            </svg>
        </div>
        <span id="controller-sync-failure-count" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerSyncFailureCount}}</span>
    </div>
    <div class="fa fa-refresh blue-border" title="Last refresh" style="font-size: x-small; padding-left: 5px;">
        <div class="icon-nifi-home-2">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 12.245 13.418">
                <defs>
                    <style>.a {
                    }</style>
                </defs>
                <path class="a"
                      d="M187.705,140.9l-1.686-1.76a4.357,4.357,0,0,0,.22-8.652l-1.54-1.54h.66a5.98,5.98,0,0,1,6.086,5.866,5.876,5.876,0,0,1-3.153,5.133v1.466l-.587-.513Zm-1.613-.293c-.22,0-.513.073-.807.073a5.98,5.98,0,0,1-6.086-5.866,5.876,5.876,0,0,1,3.153-5.133V128l.953.953,1.466,1.466a4.384,4.384,0,0,0-.147,8.725Z"
                      transform="translate(-179.2 -128)"/>
            </svg>
        </div>
        <span id="stats-last-refreshed" class="span-you">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.statsLastRefreshed}}</span>
    </div>
    <div style="flex: 1;display: flex;flex-direction: column;align-items: flex-start;justify-content: flex-end;overflow-y: auto;min-height: 35%;">
        <div id="canvas-loading-container2" class="loading-container">File Management</div>
        <md-menu-content id="global-menu-content" class="global-menu-open">
            <md-menu-item layout-align="space-around center">
                <a id="reporting-link"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.summary.shell.launch();">
                    <i class="fa fa-table">
                        <div class="icon-nifi-home-3"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
                            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
                            <svg t="1700474395821" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                 xmlns="http://www.w3.org/2000/svg" p-id="8438"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"
                                 style="margin-left: 2px">
                                <path d="M71.296 396.8l414.336 257.408a49.664 49.664 0 0 0 52.736 0L952.704 396.8a49.92 49.92 0 0 0 0-84.864L538.368 54.272a49.664 49.664 0 0 0-52.736 0L71.296 311.808a49.92 49.92 0 0 0 0 84.992z"
                                      p-id="8439"></path>
                                <path d="M917.504 488.064L512 740.096 106.496 488.064a38.4 38.4 0 1 0-40.576 65.152L491.776 817.92a38.4 38.4 0 0 0 40.448 0l425.856-264.704a38.4 38.4 0 1 0-40.576-65.152z"
                                      p-id="8440"></path>
                                <path d="M917.504 641.664L512 893.696 106.496 641.664a38.4 38.4 0 1 0-40.576 65.152L491.776 971.52a38.4 38.4 0 0 0 40.448 0l425.856-264.704a38.4 38.4 0 1 0-40.576-65.152z"
                                      p-id="8441"></path>
                            </svg>
                        </div>
                    </i>Summary
                </a>
            </md-menu-item>
            <md-menu-item layout-align="space-around center">
                <a id="counters-link"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.counters.shell.launch();"
                   ng-class="{disabled: !appCtrl.nf.Common.canAccessCounters()}">
                    <i class="icon icon-counter">
                        <div class="icon-nifi-home-3"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
                            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
                            <svg t="1700449558327" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                 xmlns="http://www.w3.org/2000/svg" p-id="22736"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"
                                 style="margin-left: 2px">
                                <path d="M512 938.666667c-181.034667 0-271.530667 0-327.765333-62.506667C128 813.738667 128 713.130667 128 512s0-301.696 56.234667-364.202667C240.469333 85.333333 331.008 85.333333 512 85.333333c181.034667 0 271.530667 0 327.765333 62.464C896 210.346667 896 310.869333 896 512c0 201.130667 0 301.696-56.234667 364.16C783.530667 938.666667 692.992 938.666667 512 938.666667z m-117.333333-341.333334a32 32 0 0 0-64 0v32H298.666667a32 32 0 0 0 0 64h32V725.333333a32 32 0 0 0 64 0v-32H426.666667a32 32 0 0 0 0-64h-32V597.333333z m302.208-7.125333a35.541333 35.541333 0 1 1-71.082667 0 35.541333 35.541333 0 0 1 71.082667 0z m0 142.250667a35.541333 35.541333 0 1 1-71.082667 0 35.541333 35.541333 0 0 1 71.082667 0z m-106.666667-35.584a35.541333 35.541333 0 1 0 0-71.082667 35.541333 35.541333 0 0 0 0 71.082667zM768 661.333333a35.541333 35.541333 0 1 1-71.125333 0 35.541333 35.541333 0 0 1 71.125333 0zM300.842667 303.445333C298.666667 311.552 298.666667 321.493333 298.666667 341.333333s0 29.738667 2.176 37.888a64 64 0 0 0 45.226666 45.226667C354.304 426.666667 364.202667 426.666667 384 426.666667h256c19.84 0 29.738667 0 37.888-2.176a64 64 0 0 0 45.226667-45.226667C725.333333 371.029333 725.333333 361.130667 725.333333 341.333333s0-29.738667-2.176-37.888a64 64 0 0 0-45.226666-45.226666C669.738667 256 659.797333 256 640 256H384c-19.84 0-29.738667 0-37.888 2.176a64 64 0 0 0-45.226667 45.226667z"
                                      p-id="22737"></path>
                            </svg>
                        </div>
                    </i>Counters
                </a>
            </md-menu-item>
            <md-menu-item layout-align="space-around center">
                <a id="bulletin-board-link"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.bulletinBoard.shell.launch();">
                    <i class="fa fa-sticky-note-o">
                        <div class="icon-nifi-home-3"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
                            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
                            <svg t="1700461450619" class="icon" viewBox="0 0 1030 1024" version="1.1"
                                 xmlns="http://www.w3.org/2000/svg" p-id="17499"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"
                                 style="margin-left: 2px">
                                <path d="M840.606116 1011.425364l-179.92404-176.206946h118.863468l120.28348 117.986401a41.765097 41.765097 0 0 1 12.78012 30.530286 37.964474 37.964474 0 0 1-12.78012 27.732025 41.765097 41.765097 0 0 1-59.389968 0z m-711.844321 0a41.514507 41.514507 0 0 1-12.529529-30.446756 38.131534 38.131534 0 0 1 12.529529-27.773789l120.283481-117.986401h119.155823l-178.545792 176.248712a44.103943 44.103943 0 0 1-31.365588 12.529529 41.347446 41.347446 0 0 1-29.486159-12.529529zM82.110182 803.978126A81.316645 81.316645 0 0 1 0 723.622078V171.738081a81.316645 81.316645 0 0 1 82.068416-80.188987H948.067712a81.316645 81.316645 0 0 1 81.984886 80.147222v553.262245A82.945483 82.945483 0 0 1 948.067712 803.978126z m87.706704-246.706431a41.096856 41.096856 0 0 0 42.475104 41.765097H689.124108a41.765097 41.765097 0 1 0-1.420014-83.154309H212.250225a41.096856 41.096856 0 0 0-42.475104 41.305682z m0-205.150159a41.096856 41.096856 0 0 0 42.475104 41.765098h241.94521a41.765097 41.765097 0 1 0 0-83.154309H212.250225a41.096856 41.096856 0 0 0-42.475104 41.305681z m387.747165-280.118508h-84.866678v-30.906172a42.475104 42.475104 0 0 1 84.866678 0v31.365588z"
                                      p-id="17500"></path>
                            </svg>
                        </div>
                    </i>Bulletin Board
                </a>
            </md-menu-item>
            <md-menu-divider></md-menu-divider>
            <md-menu-item
                    layout-align="space-around center">
                <a id="provenance-link"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.dataProvenance.shell.launch();"
                   ng-class="{disabled: !appCtrl.nf.Common.canAccessProvenance()}">
                    <i class="icon icon-provenance">
                        <div class="icon-nifi-home-3"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
                            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
                            <svg t="1700461779488" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                 xmlns="http://www.w3.org/2000/svg" p-id="27286"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"
                                 style="margin-left: 2px">
                                <path d="M512 512V85.333333a426.666667 426.666667 0 1 0 426.666667 426.666667z"
                                      p-id="27287"></path>
                                <path d="M576 90.645333V448h357.354667A426.261333 426.261333 0 0 0 576 90.645333z"
                                      p-id="27288"></path>
                            </svg>
                        </div>
                    </i>Data Provenance
                </a>
            </md-menu-item>
            <md-menu-divider></md-menu-divider>
            <md-menu-item layout-align="space-around center">
                <a id="flow-settings-link"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.controllerSettings.shell.launch();">
                    <i class="fa fa-wrench">
                        <div class="icon-nifi-home-4"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
                            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
                            <svg t="1700462249628" class="icon" viewBox="0 0 1824 1024" version="1.1"
                                 xmlns="http://www.w3.org/2000/svg" p-id="28249"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" style="width: 20px;">
                                <path d="M1264.426 249.49l-106.045-28.353-28.514-106.205 108.287-108.287c-63.915-17.3-135.039-0.801-185.178 49.338-50.459 50.459-66.799 122.224-49.018 186.459l-292.344 292.183c-64.236-17.781-135.84-1.442-186.299 49.018-50.139 50.139-66.638 121.263-49.338 185.338l108.287-108.447 106.045 28.514 28.514 106.045-108.287 108.287c63.915 17.3 135.039 0.961 185.178-49.178 52.702-52.702 68.24-128.631 46.455-194.789l286.417-286.417c66.318 21.625 142.087 6.087 194.789-46.615 50.139-50.139 66.638-121.263 49.338-185.178l-108.287 108.287z"
                                      p-id="28250"></path>
                            </svg>
                        </div>
                    </i>Controller Settings
                </a>
            </md-menu-item>
            <md-menu-item layout-align="space-around center">
                <a id="parameter-contexts-link"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.parameterContexts.shell.launch();">
                    <i class="fa">
                        <div class="icon-nifi-home-4"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
                            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
                            <svg t="1700462407465" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                 xmlns="http://www.w3.org/2000/svg" p-id="32543"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"
                                 style="margin-left: 2px">
                                <path d="M659.456 315.392l-20.48-1.024c-12.288 0-22.528-8.192-25.6-19.456-4.096-12.288-8.192-23.552-14.336-33.792-5.12-10.24-4.096-23.552 4.096-32.768l14.336-15.36c10.24-11.264 10.24-28.672-1.024-38.912l-16.384-16.384-16.384-15.36c-10.24-10.24-27.648-11.264-38.912-1.024l-15.36 14.336c-9.216 8.192-21.504 9.216-32.768 4.096s-22.528-10.24-33.792-14.336c-11.264-4.096-19.456-13.312-19.456-25.6l-1.024-20.48c-1.024-15.36-13.312-27.648-28.672-27.648H368.64c-15.36 0-27.648 12.288-27.648 26.624l-1.024 20.48c0 12.288-8.192 22.528-19.456 25.6-12.288 4.096-23.552 8.192-33.792 14.336-10.24 5.12-23.552 4.096-32.768-4.096l-15.36-14.336c-11.264-10.24-28.672-10.24-38.912 1.024l-16.384 16.384-16.384 16.384c-10.24 10.24-11.264 27.648-1.024 38.912l14.336 15.36c8.192 9.216 9.216 21.504 4.096 32.768s-10.24 22.528-14.336 33.792c-4.096 11.264-13.312 19.456-25.6 19.456l-20.48 1.024c-15.36 1.024-26.624 13.312-26.624 27.648v46.08c0 15.36 12.288 27.648 26.624 27.648l20.48 1.024c12.288 0 22.528 8.192 25.6 19.456 4.096 12.288 8.192 23.552 14.336 33.792 5.12 10.24 4.096 23.552-4.096 32.768l-14.336 15.36c-10.24 11.264-10.24 28.672 1.024 38.912l16.384 16.384 16.384 16.384c10.24 10.24 27.648 11.264 38.912 1.024l15.36-14.336c9.216-8.192 21.504-9.216 32.768-4.096s22.528 10.24 33.792 14.336c11.264 4.096 19.456 13.312 19.456 25.6l1.024 20.48c1.024 15.36 13.312 26.624 27.648 26.624h45.056c15.36 0 27.648-12.288 27.648-26.624l1.024-20.48c0-12.288 8.192-22.528 19.456-25.6 12.288-4.096 23.552-8.192 33.792-14.336 10.24-5.12 23.552-4.096 32.768 4.096l15.36 14.336c11.264 10.24 28.672 10.24 38.912-1.024l16.384-16.384 16.384-16.384c10.24-10.24 11.264-27.648 1.024-38.912l-14.336-15.36c-8.192-9.216-9.216-21.504-4.096-32.768s10.24-22.528 14.336-33.792c4.096-11.264 13.312-19.456 25.6-19.456l20.48-1.024c15.36-1.024 26.624-13.312 26.624-27.648v-45.056c1.024-15.36-11.264-27.648-25.6-28.672zM391.168 477.184c-61.44 0-110.592-49.152-110.592-110.592S329.728 256 391.168 256 501.76 305.152 501.76 366.592s-49.152 110.592-110.592 110.592z m546.816 292.864l-13.312-6.144c-7.168-3.072-11.264-11.264-11.264-19.456 1.024-8.192 1.024-17.408 0-25.6s4.096-16.384 11.264-19.456l13.312-6.144c9.216-4.096 14.336-15.36 10.24-24.576l-6.144-14.336L935.936 640c-4.096-9.216-14.336-14.336-24.576-11.264l-13.312 5.12c-8.192 3.072-16.384 0-21.504-6.144s-11.264-12.288-17.408-18.432c-6.144-5.12-8.192-14.336-6.144-21.504l5.12-13.312c4.096-9.216-1.024-20.48-10.24-24.576l-14.336-6.144L819.2 537.6c-9.216-4.096-20.48 0-24.576 9.216l-6.144 13.312c-3.072 7.168-11.264 11.264-19.456 11.264-8.192-1.024-17.408-1.024-25.6 0s-16.384-4.096-19.456-11.264l-6.144-13.312c-4.096-9.216-15.36-14.336-24.576-10.24l-14.336 6.144-14.336 6.144c-9.216 4.096-14.336 14.336-11.264 24.576l5.12 13.312c3.072 8.192 0 16.384-6.144 21.504S640 619.52 633.856 625.664c-5.12 6.144-14.336 8.192-21.504 6.144l-13.312-5.12c-9.216-4.096-20.48 1.024-24.576 10.24l-6.144 14.336-6.144 14.336c-4.096 9.216 0 20.48 9.216 24.576l13.312 6.144c7.168 3.072 11.264 11.264 11.264 19.456-1.024 8.192-1.024 17.408 0 25.6s-4.096 16.384-11.264 19.456l-13.312 6.144c-9.216 4.096-14.336 15.36-10.24 24.576l6.144 14.336 6.144 14.336c4.096 9.216 14.336 14.336 24.576 11.264l13.312-5.12c8.192-3.072 16.384 0 21.504 6.144s11.264 12.288 17.408 18.432c6.144 5.12 8.192 14.336 6.144 21.504l-5.12 13.312c-4.096 9.216 1.024 20.48 10.24 24.576l14.336 6.144 14.336 6.144c9.216 4.096 20.48 0 24.576-9.216l6.144-13.312c3.072-7.168 11.264-11.264 19.456-11.264 8.192 1.024 17.408 1.024 25.6 0s16.384 4.096 19.456 11.264l6.144 13.312c4.096 9.216 15.36 14.336 24.576 10.24l14.336-6.144 14.336-6.144c9.216-4.096 14.336-14.336 11.264-24.576l-5.12-13.312c-3.072-8.192 0-16.384 6.144-21.504s12.288-11.264 18.432-17.408c5.12-6.144 14.336-8.192 21.504-6.144l13.312 5.12c9.216 4.096 20.48-1.024 24.576-10.24l6.144-14.336 6.144-14.336c4.096-9.216 0-20.48-9.216-24.576z m-212.992 29.696c-38.912-16.384-56.32-61.44-39.936-99.328 16.384-38.912 61.44-56.32 99.328-39.936 38.912 16.384 56.32 61.44 39.936 99.328-16.384 38.912-60.416 56.32-99.328 39.936z"
                                      p-id="32544"></path>
                            </svg>
                        </div>
                    </i>Parameter Contexts
                </a>
            </md-menu-item>
            <md-menu-item ng-if="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.cluster.visible();"
                          layout-align="space-around center">
                <a id="cluster-link"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.cluster.shell.launch();"
                   ng-class="{disabled: !appCtrl.nf.Common.canAccessController()}">
                    <i class="fa fa-cubes"><img src="images/Cluster.svg" style="height: 26px; width: 26px;"></i>Cluster
                </a>
            </md-menu-item>
            <md-menu-item layout-align="space-around center">
                <a id="history-link"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.flowConfigHistory.shell.launch();">
                    <i class="fa fa-history">
                        <div class="icon-nifi-home-4"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
                            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
                            <svg t="1700464850046" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                 xmlns="http://www.w3.org/2000/svg" p-id="38257"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"
                                 style="margin-left: 2px">
                                <path d="M511.215 62.066c-247.841 0-448.76 200.919-448.76 448.766 0 247.841 200.919 448.76 448.76 448.76 247.847 0 448.766-200.919 448.766-448.76 0-247.847-200.919-448.766-448.766-448.766zM734.022 733.632c-5.145 5.145-11.888 7.718-18.625 7.718-6.743 0-13.486-2.573-18.63-7.718l-211.887-211.893v-267.967c0-14.558 11.803-26.348 26.342-26.348 14.545 0 26.348 11.791 26.348 26.348v246.152l196.452 196.452c10.289 10.278 10.289 26.971 0 37.256z"
                                      p-id="38258"></path>
                            </svg>
                        </div>
                    </i>Configuration History
                </a>
            </md-menu-item>
            <md-menu-item layout-align="space-around center">
                <a id="status-history-link"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.nodeStatusHistory.shell.launch();">
                    <i class="fa fa-area-chart">
                        <div class="icon-nifi-home-4"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
                            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
                            <svg t="1700447789638" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                 xmlns="http://www.w3.org/2000/svg" p-id="1929"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"
                                 style="margin-left: 2px">
                                <path d="M762 112c55.228 0 100 44.772 100 100v350c0 193.3-156.7 350-350 350H262c-55.228 0-100-44.772-100-100V212c0-55.228 44.772-100 100-100h500zM562 562H362c-27.614 0-50 22.386-50 50s22.386 50 50 50h200c27.614 0 50-22.386 50-50s-22.386-50-50-50z m100-250H362c-27.614 0-50 22.386-50 50s22.386 50 50 50h300c27.614 0 50-22.386 50-50s-22.386-50-50-50z"
                                      p-id="1930"></path>
                            </svg>
                        </div>
                    </i>Node Status History
                </a>
            </md-menu-item>
            <md-menu-divider ng-if="appCtrl.nf.CanvasUtils.isManagedAuthorizer()"></md-menu-divider>
            <md-menu-item layout-align="space-around center" ng-if="appCtrl.nf.CanvasUtils.isManagedAuthorizer()">
                <a id="users-link" layout="column"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.users.shell.launch();"
                   ng-class="{disabled: !(appCtrl.nf.Common.canAccessTenants())}">
                    <i class="fa fa-users"></i>Users
                </a>
            </md-menu-item>
            <md-menu-item layout-align="space-around center" ng-if="appCtrl.nf.CanvasUtils.isManagedAuthorizer()">
                <a id="policies-link" layout="column"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.policies.shell.launch();"
                   ng-class="{disabled: !(appCtrl.nf.Common.canAccessTenants() && appCtrl.nf.Common.canModifyPolicies())}">
                    <i class="fa fa-key"></i>Policies
                </a>
            </md-menu-item>
            <md-menu-divider></md-menu-divider>
            <md-menu-item layout-align="space-around center">
                <a id="templates-link"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.templates.shell.launch();">
                    <i class="icon icon-template">
                        <div class="icon-nifi-home-5"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
                            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
                            <svg t="1700462659978" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                 xmlns="http://www.w3.org/2000/svg" p-id="35311"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"
                                 style="margin-left: 2px">
                                <path d="M896 320H128V160c0-17.6 14.4-32 32-32h704c17.6 0 32 14.4 32 32v160zM320 896H160c-17.6 0-32-14.4-32-32V384h192v512zM864 896H384V384h512v480c0 17.6-14.4 32-32 32z"
                                      p-id="35312"></path>
                            </svg>
                        </div>
                    </i>Templates
                </a>
            </md-menu-item>
            <md-menu-divider></md-menu-divider>
            <%--        <md-menu-item layout-align="space-around center">--%>
            <%--            <a id="help-link"--%>
            <%--               ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.help.shell.launch();">--%>
            <%--                <i class="fa fa-question-circle"><div class="icon-nifi-home-5"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"><svg t="1700462748271" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="36289" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" style="margin-left: 2px"><path d="M505.6 70.4c-243.2 0-435.2 192-435.2 435.2s192 435.2 435.2 435.2 435.2-192 435.2-435.2-192-435.2-435.2-435.2z m38.4 716.8H473.6v-70.4h70.4v70.4z m108.8-313.6c-12.8 19.2-32 38.4-57.6 70.4-19.2 12.8-32 32-38.4 38.4-6.4 6.4-12.8 19.2-12.8 25.6 0 12.8-6.4 25.6-6.4 51.2h-57.6V640c0-25.6 6.4-44.8 12.8-64 0-6.4 6.4-19.2 19.2-32 6.4-12.8 25.6-25.6 44.8-44.8 19.2-19.2 32-32 38.4-44.8 6.4-12.8 6.4-25.6 6.4-38.4 0-25.6-6.4-44.8-25.6-64-19.2-12.8-38.4-25.6-64-25.6s-51.2 6.4-64 25.6c-19.2 19.2-32 44.8-38.4 76.8l-64-6.4c6.4-44.8 25.6-83.2 51.2-108.8 25.6-25.6 64-38.4 108.8-38.4 51.2 0 89.6 12.8 115.2 38.4 32 25.6 44.8 57.6 44.8 96 6.4 25.6 0 44.8-12.8 64z" p-id="36290"></path></svg></div></i>Help--%>
            <%--            </a>--%>
            <%--        </md-menu-item>--%>
            <md-menu-item layout-align="space-around center">
                <a id="about-link"
                   ng-click="appCtrl.serviceProvider.headerCtrl.globalMenuCtrl.about.modal.show();">
                    <i class="fa fa-info-circle">
                        <div class="icon-nifi-home-5"><?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC
                            "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
                            <svg t="1700462854092" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                 xmlns="http://www.w3.org/2000/svg" p-id="37272"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"
                                 style="margin-left: 2px">
                                <path d="M512.6 136.4c-206.4 0-373.7 167.3-373.7 373.7s167.3 373.7 373.7 373.7 373.7-167.3 373.7-373.7S719 136.4 512.6 136.4z m35.2 573c0 8.8-7.2 15.9-15.9 15.9h-38.5c-8.8 0-15.9-7.2-15.9-15.9V453.3c0-8.8 7.2-15.9 15.9-15.9h38.5c8.8 0 15.9 7.2 15.9 15.9v256.1z m-35.2-344.2c-19.4 0-35.2-15.8-35.2-35.2 0-19.4 15.8-35.2 35.2-35.2 19.4 0 35.2 15.8 35.2 35.2 0 19.4-15.8 35.2-35.2 35.2z"
                                      p-id="37273"></path>
                            </svg>
                        </div>
                    </i>About
                </a>
            </md-menu-item>
        </md-menu-content>
    </div>

</div>
<%--    <div layout="row" layout-align="end center">--%>
<%--        <div id="search-container">--%>
<%--            <button id="search-button" ng-click="appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.search.toggleSearchField();"><i class="fa fa-search"></i></button>--%>
<%--            <input id="search-field" type="text" placeholder="Search"/>--%>
<%--        </div>--%>
<%--        <button id="bulletin-button"><i class="fa fa-sticky-note-o"></i></button>--%>
<%--    </div>--%>
<%--</div>--%>
<div id="search-flow-results"></div>
