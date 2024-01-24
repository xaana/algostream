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

/* global define, module, require, exports */
// ???????? styleElem ??
var styleElem;
(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define(['jquery',
                'nf.Common',
                'nf.Dialog',
                'nf.CanvasUtils',
                'nf.ContextMenu',
                'nf.ClusterSummary',
                'nf.ErrorHandler',
                'nf.Settings',
                'nf.ParameterContexts',
                'nf.ProcessGroup',
                'nf.ProcessGroupConfiguration'],
            function ($, nfCommon, nfDialog, nfCanvasUtils, nfContextMenu, nfClusterSummary, nfErrorHandler, nfSettings, nfParameterContexts, nfProcessGroup, nfProcessGroupConfiguration) {
                return (nf.ng.Canvas.FlowStatusCtrl = factory($, nfCommon, nfDialog, nfCanvasUtils, nfContextMenu, nfClusterSummary, nfErrorHandler, nfSettings, nfParameterContexts, nfProcessGroup, nfProcessGroupConfiguration));
            });
    } else if (typeof exports === 'object' && typeof module === 'object') {
        module.exports = (nf.ng.Canvas.FlowStatusCtrl =
            factory(require('jquery'),
                require('nf.Common'),
                require('nf.Dialog'),
                require('nf.CanvasUtils'),
                require('nf.ContextMenu'),
                require('nf.ClusterSummary'),
                require('nf.ErrorHandler'),
                require('nf.Settings'),
                require('nf.ParameterContexts'),
                require('nf.ProcessGroup'),
                require('nf.ProcessGroupConfiguration')));
    } else {
        nf.ng.Canvas.FlowStatusCtrl = factory(root.$,
            root.nf.Common,
            root.nf.Dialog,
            root.nf.CanvasUtils,
            root.nf.ContextMenu,
            root.nf.ClusterSummary,
            root.nf.ErrorHandler,
            root.nf.Settings,
            root.nf.ParameterContexts,
            root.nf.ProcessGroup,
            root.nf.ProcessGroupConfiguration);
    }
}(this, function ($, nfCommon, nfDialog, nfCanvasUtils, nfContextMenu, nfClusterSummary, nfErrorHandler, nfSettings, nfParameterContexts, nfProcessGroup, nfProcessGroupConfiguration) {
    'use strict';

    return function (serviceProvider) {
        'use strict';

        var config = {
            search: 'Search',
            urls: {
                search: '../nifi-api/flow/search-results',
                status: '../nifi-api/flow/status'
            }
        };

        function FlowStatusCtrl() {
            this.connectedNodesCount = "-";
            this.clusterConnectionWarning = false;
            this.activeThreadCount = "-";
            this.terminatedThreadCount = "-";
            this.threadCounts = "-";
            this.totalQueued = "-";
            this.controllerTransmittingCount = "-";
            this.controllerNotTransmittingCount = "-";
            this.controllerRunningCount = "-";
            this.controllerStoppedCount = "-";
            this.controllerInvalidCount = "-";
            this.controllerDisabledCount = "-";
            this.controllerUpToDateCount = "-";
            this.controllerLocallyModifiedCount = "-";
            this.controllerStaleCount = "-";
            this.controllerLocallyModifiedAndStaleCount = "-";
            this.controllerSyncFailureCount = "-";
            this.statsLastRefreshed = "-";

            /**
             * The search controller.
             */
            this.search = {

                /**
                 * Get the search input element.
                 */
                getInputElement: function () {
                    return $('#search-field');
                },

                /**
                 * Get the search button element.
                 */
                getButtonElement: function () {
                    return $('#search-button');
                },

                /**
                 * Get the search container element.
                 */
                getSearchContainerElement: function () {
                    return $('#search-container');
                },

                /**
                 * Initialize the search controller.
                 */
                init: function () {

                    var searchCtrl = this;

                    // Create new jQuery UI widget
                    $.widget('nf.searchAutocomplete', $.ui.autocomplete, {
                        reset: function () {
                            this.term = null;
                        },
                        _create: function () {
                            this._super();
                            this.widget().menu('option', 'items', '> :not(.search-header, .search-no-matches)');
                        },
                        _resizeMenu: function () {
                            var ul = this.menu.element;
                            ul.width(400);
                        },
                        _normalize: function (searchResults) {
                            var items = [];
                            items.push(searchResults);
                            return items;
                        },
                        _renderMenu: function (ul, items) {
                            var nfSearchAutocomplete = this;

                            // the object that holds the search results is normalized into a single element array
                            var searchResults = items[0];

                            // show all processors
                            if (!nfCommon.isEmpty(searchResults.processorResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon icon-processor"></div>Processors</li>');
                                $.each(searchResults.processorResults, function (i, processorMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, processorMatch, { type: 'processor' }));
                                });
                            }

                            // show all process groups
                            if (!nfCommon.isEmpty(searchResults.processGroupResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon icon-group"></div>Process Groups</li>');
                                $.each(searchResults.processGroupResults, function (i, processGroupMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, processGroupMatch, { type: 'process group' }));
                                });
                            }

                            // show all remote process groups
                            if (!nfCommon.isEmpty(searchResults.remoteProcessGroupResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon icon-group-remote"></div>Remote Process Groups</li>');
                                $.each(searchResults.remoteProcessGroupResults, function (i, remoteProcessGroupMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, remoteProcessGroupMatch, { type: 'remote process group' }));
                                });
                            }

                            // show all connections
                            if (!nfCommon.isEmpty(searchResults.connectionResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon icon-connect"></div>Connections</li>');
                                $.each(searchResults.connectionResults, function (i, connectionMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, connectionMatch, { type: 'connection' }));
                                });
                            }

                            // show all input ports
                            if (!nfCommon.isEmpty(searchResults.inputPortResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon icon-port-in"></div>Input Ports</li>');
                                $.each(searchResults.inputPortResults, function (i, inputPortMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, inputPortMatch, { type: 'input port' }));
                                });
                            }

                            // show all output ports
                            if (!nfCommon.isEmpty(searchResults.outputPortResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon icon-port-out"></div>Output Ports</li>');
                                $.each(searchResults.outputPortResults, function (i, outputPortMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, outputPortMatch, { type: 'output port' }));
                                });
                            }

                            // show all funnels
                            if (!nfCommon.isEmpty(searchResults.funnelResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon icon-funnel"></div>Funnels</li>');
                                $.each(searchResults.funnelResults, function (i, funnelMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, funnelMatch, { type: 'funnel' }));
                                });
                            }

                            // show all labels
                            if (!nfCommon.isEmpty(searchResults.labelResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon icon-label"></div>Labels</li>');
                                $.each(searchResults.labelResults, function (i, labelMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, labelMatch, { type: 'label' }));
                                });
                            }

                            // show all controller services
                            if (!nfCommon.isEmpty(searchResults.controllerServiceNodeResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon"></div>Controller Services</li>');
                                $.each(searchResults.controllerServiceNodeResults, function (i, controllerServiceMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, controllerServiceMatch, { type: 'controller service' }));
                                });
                            }

                            // show all parameter providers
                            if (!nfCommon.isEmpty(searchResults.parameterProviderNodeResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon"></div>Parameter Providers</li>');
                                $.each(searchResults.parameterProviderNodeResults, function (i, parameterProviderMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, parameterProviderMatch, { type: 'parameter provider' }));
                                });
                            }

                            // show all parameter contexts and parameters
                            if (!nfCommon.isEmpty(searchResults.parameterContextResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon"></div>Parameter Contexts</li>');
                                $.each(searchResults.parameterContextResults, function (i, parameterContextMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, parameterContextMatch, { type: 'parameter context' }));
                                });
                            }

                            // show all parameters
                            if (!nfCommon.isEmpty(searchResults.parameterResults)) {
                                ul.append('<li class="search-header"><div class="search-result-icon icon"></div>Parameters</li>');
                                $.each(searchResults.parameterResults, function (i, parameterMatch) {
                                    nfSearchAutocomplete._renderItem(ul, $.extend({}, parameterMatch, { type: 'parameter' }));
                                });
                            }

                            // ensure there were some results
                            if (ul.children().length === 0) {
                                ul.append('<li class="unset search-no-matches">No results matched the search terms</li>');
                            }
                        },
                        _renderItem: function (ul, match) {
                            var itemHeader = $('<div class="search-match-header"></div>').text(match.name);
                            var itemContent = $('<a></a>').append(itemHeader);

                            if (match.type !== 'parameter context' && match.type !== 'parameter') {
                                var parentGroupHeader = $('<div class="search-match-header"></div>').append(document.createTextNode('Parent: '));
                                var parentGroup = '-';
                                if (nfCommon.isDefinedAndNotNull(match.parentGroup)) {
                                    parentGroup = match.parentGroup.name ? match.parentGroup.name : match.parentGroup.id;
                                }
                                parentGroupHeader = parentGroupHeader.append($('<span></span>').text(parentGroup));

                                var versionedGroupHeader = $('<div class="search-match-header"></div>').append(document.createTextNode('Versioned: '));
                                var versionedGroup = '-';

                                if (nfCommon.isDefinedAndNotNull(match.versionedGroup)) {
                                    versionedGroup = match.versionedGroup.name ? match.versionedGroup.name : match.versionedGroup.id;
                                }

                                versionedGroupHeader = versionedGroupHeader.append($('<span></span>').text(versionedGroup));
                                // create a search item wrapper
                                itemContent.append(parentGroupHeader).append(versionedGroupHeader);
                            } else if (match.type === 'parameter') {
                                var paramContextHeader = $('<div class="search-match-header"></div>').append(document.createTextNode('Parameter Context: '));
                                var paramContext = '-';
                                if (nfCommon.isDefinedAndNotNull(match.parentGroup)) {
                                    paramContext = match.parentGroup.name ? match.parentGroup.name : match.parentGroup.id;
                                }
                                paramContextHeader = paramContextHeader.append($('<span></span>').text(paramContext));
                                itemContent.append(paramContextHeader);
                            }

                            // append all matches
                            $.each(match.matches, function (i, match) {
                                itemContent.append($('<div class="search-match"></div>').text(match));
                            });
                            return $('<li></li>').data('ui-autocomplete-item', match).append(itemContent).appendTo(ul);
                        }
                    });

                    // configure the new searchAutocomplete jQuery UI widget
                    this.getInputElement().searchAutocomplete({
                        delay: 1000,
                        appendTo: '#search-flow-results',
                        position: {
                            my: 'right top',
                            at: 'right bottom',
                            offset: '1 1'
                        },
                        source: function (request, response) {
                            // create the search request
                            $.ajax({
                                type: 'GET',
                                data: {
                                    q: request.term,
                                    a: nfCanvasUtils.getGroupId()
                                },
                                dataType: 'json',
                                url: config.urls.search
                            }).done(function (searchResponse) {
                                response(searchResponse.searchResultsDTO);
                            });
                        },
                        select: function (event, ui) {
                            var item = ui.item;

                            switch (item.type) {
                                case 'parameter context':
                                    nfParameterContexts.showParameterContexts(item.id);
                                    break;
                                case 'parameter':
                                    var paramContext = item.parentGroup;
                                    nfParameterContexts.showParameterContext(paramContext.id, null, item.name);
                                    break;
                                case 'controller service':
                                    var group = item.parentGroup;
                                    nfProcessGroup.enterGroup(group.id).done(function () {
                                        nfProcessGroupConfiguration.showConfiguration(group.id).done(function () {
                                            nfProcessGroupConfiguration.selectControllerService(item.id);
                                        });
                                    });
                                    break;
                                default:
                                    var group = item.parentGroup;

                                    // show the selected component
                                    nfCanvasUtils.showComponent(group.id, item.id);
                                    break;
                            }

                            searchCtrl.getInputElement().val('').blur();

                            // stop event propagation
                            return false;
                        },
                        open: function (event, ui) {
                            // show the glass pane
                            var searchField = $(this);
                            $('<div class="search-glass-pane"></div>').one('click', function () {
                            }).appendTo('body');
                        },
                        close: function (event, ui) {
                            // set the input text to '' and reset the cached term
                            $(this).searchAutocomplete('reset');
                            searchCtrl.getInputElement().val('');

                            // remove the glass pane
                            $('div.search-glass-pane').remove();
                        }
                    });

                    // hide the search input
                    searchCtrl.toggleSearchField();
                },

                themeToggle: function () {
                    // ?? iframe ??
                    var iframe = document.getElementById('shell-iframe');
                    if (iframe) {
                        // ?? iframe ?????
                        var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
                    }
                    //??????
                    // ???????????,????????
                    const elements = document.querySelectorAll('#process-group-configuration, div.summary-table, #flow-status2, .graph-control button, #graph-controls .icon, #data-flow-title-viewport, #breadcrumbs, .theme-element, #canvas-body, .global-menu-open, .layout-align-space-between-end, #current-user, #shell-dialog, #search-container, #shell-container, #counters, summary-table, .slick-cell, .slick-headerrow-column, div.summary-table, .slick-header-column.ui-state-default, .slick-row.ui-widget-content, .slick-row.ui-state-active, #summary, #aa, .aa, body, #summary-tabs, body.md-default-theme, html.md-default-theme, html, div[id$="-tabs-content"], .grid-canvas, #flow-summary-refresh-container, .large-dialog, .dialog-header, #new-port-dialog, #new-process-group-dialog, .dialog, .setting-name, g.connection path.connection-path, .dialog, .dialog-header, .dialog-status-bar, #global-menu-content a, div.context-menu-item-text, #prioritizer-available, #prioritizer-selected, .CodeMirror-scroll, .slickgrid-nf-editor');//.slick-cell, .slick-headerrow-column
                    // ??????
                    var theme = 'light';
                    // ????
                    if (document.body.classList.contains('dark')) {
                        theme = 'light';
                    } else {
                        theme = 'dark';
                    }
                    // ??????,??????????????
                    for (var i = 0; i < elements.length; i++) {
                        // ????
                        var element = elements[i];
                        if (theme === 'dark') {
                            element.classList.add('dark');
                            element.classList.remove('light');
                        } else if (theme === 'light') {
                            element.classList.add('light');
                            element.classList.remove('dark');
                        }
                    }
                    //??????
                    // ???????????,????????
                    const elementsb = document.querySelectorAll('#global-menu-content, #flow-status');
                    // ??????,??????????????
                    for (var i = 0; i < elementsb.length; i++) {
                        // ????
                        var element = elementsb[i];
                        if (theme === 'dark') {
                            element.classList.add('dark-b');
                            element.classList.remove('light');
                        } else if (theme === 'light') {
                            element.classList.add('light');
                            element.classList.remove('dark-b');
                        }
                    }
                    // ?????????????
                    sessionStorage.setItem('theme', theme);
                    //??????
                    // ???????????,????????
                    const elements2 = document.querySelectorAll('.bb, .combo-text, .icon-threads, .blue-border, #search-button, #canvas-container, #graph-control, .slick-header-column, textarea, #general-process-group-configuration input, #general-process-group-configuration textarea, #processor-comments, .tab, .tab button, input[type="text"], input[type="password"], input[type=text], input[type=password], #parameter-context-available, #parameter-context-selected');
                    // ??????
                    var theme2 = 'light';
                    // ????
                    if (document.body.classList.contains('dark')) {
                        theme2 = 'dark2';
                    } else {
                        theme2 = 'light';
                    }
                    // ??????,??????????????
                    for (var i = 0; i < elements2.length; i++) {
                        // ????
                        var element = elements2[i];
                        if (theme2 === 'dark2') {
                            element.classList.add('dark2');
                            element.classList.remove('light');
                        } else if (theme2 === 'light') {
                            element.classList.add('light');
                            element.classList.remove('dark2');
                        }
                    }

                    const elementsb2 = document.querySelectorAll(' #search-field, .search, .context-menu, #prioritizer-available li, #parameter-providers-table');
                    // ??????,??????????????
                    for (var i = 0; i < elementsb2.length; i++) {
                        // ????
                        var element = elementsb2[i];
                        element.classList.remove('dark2');
                        if (theme === 'dark') {
                            element.classList.add('dark-b2');
                            element.classList.remove('light-search');
                        } else if (theme === 'light') {
                            element.classList.add('light-search');
                            element.classList.remove('dark-b2');
                        }
                    }
                    const elements2b = document.querySelectorAll(' .graph-control')
                    // ??????,??????????????
                    for (var i = 0; i < elements2b.length; i++) {
                        // ????
                        var element = elements2b[i];
                        if (theme2 === 'dark2') {
                            element.classList.add('dark2-b');
                            element.classList.remove('light');
                        } else if (theme2 === 'light') {
                            element.classList.add('light');
                            element.classList.remove('dark2-b');
                        }
                    }
                    //Cancel ????
                    const elementsC = document.querySelectorAll('.cc, #cc, .CodeMirror-gutters, div.secondary-button')//div.button,
                    // ??????,??????????????
                    for (var i = 0; i < elementsC.length; i++) {
                        // ????
                        var element = elementsC[i];
                        if (theme2 === 'dark2') {
                            element.classList.add('dark-button');
                            element.classList.remove('light-button');
                        } else if (theme2 === 'light') {
                            element.classList.add('light-button');
                            element.classList.remove('dark-button');
                        }
                    }
                    const elementsCb = document.querySelectorAll('div.button')//div.button,
                    // ??????,??????????????
                    for (var i = 0; i < elementsCb.length; i++) {
                        // ????
                        var element = elementsCb[i];
                        if (theme2 === 'dark2') {
                            element.classList.add('dark-button-b');
                            element.classList.remove('light-button');
                        } else if (theme2 === 'light') {
                            element.classList.add('light-button');
                            element.classList.remove('dark-button-b');
                        }
                    }
                    //table
                    const elementsTable = document.querySelectorAll('#controller-services-table, #reporting-tasks-table, #flow-analysis-rules-table, #registries-table, #parameter-contexts-table, #templates-table')
                    // ??????,??????????????
                    for (var i = 0; i < elementsTable.length; i++) {
                        // ????
                        var element = elementsTable[i];
                        if (theme2 === 'dark2') {
                            element.classList.add('dark-table');
                            element.classList.remove('light-table');
                        } else if (theme2 === 'light') {
                            element.classList.add('light-table');
                            element.classList.remove('dark-table');
                        }
                    }
                    //?????iframe?css ???
                    const elementsL = document.querySelectorAll('.combo, .combo-open')
                    // ??????,??????????????
                    for (var i = 0; i < elementsL.length; i++) {
                        // ????
                        var element = elementsL[i];
                        if (theme2 === 'dark2') {
                            element.classList.add('dark-l');
                            element.classList.remove('light');
                        } else if (theme2 === 'light') {
                            element.classList.add('light');
                            element.classList.remove('dark-l');
                        }
                    }
                    // ?????????????
                    // sessionStorage.setItem('theme2', theme2);
                    // //??????-?????
                    // // ???????????,????????
                    // const elements22 = document.querySelectorAll('.tab, .tab button, input[type="text"], input[type="password"]');
                    // // ??????
                    // var theme2 = 'light';
                    // // ????
                    // if (document.body.classList.contains('dark')) {
                    //     theme2 = 'dark22';
                    // } else {
                    //     theme2 = 'light';
                    // }
                    // // ??????,??????????????
                    // for (var i = 0; i < elements22.length; i++) {
                    //     // ????
                    //     var element = elements22[i];
                    //     if (theme2 === 'dark22') {
                    //         element.classList.add('dark22');
                    //         element.classList.remove('light');
                    //     } else if (theme2 === 'light') {
                    //         element.classList.add('light');
                    //         element.classList.remove('dark22');
                    //     }
                    // }



                    //??fill????
                    // ???????????,????????
                    const elementsFill = document.querySelectorAll('.aa-fill');//, g.component rect.body
                    // ??????
                    var theme3 = 'light';
                    // ????
                    if (document.body.classList.contains('dark')) {
                        theme3 = 'dark-fill';
                    } else {
                        theme3 = 'light';
                    }
                    // ??????,??????????????
                    for (var i = 0; i < elementsFill.length; i++) {
                        // ????
                        var element = elementsFill[i];
                        if (theme3 === 'dark-fill') {
                            element.classList.add('dark-fill');
                            element.classList.remove('light');
                        } else if (theme3 === 'light') {
                            element.classList.add('light');
                            element.classList.remove('dark-fill');
                        }
                    }
                    // ?????????????
                    // sessionStorage.setItem('theme3', theme3);





                    //??????
                    // ???????????,????????
                    const elementsFillFont = document.querySelectorAll('text.stats-label, text.port-name');
                    // ??????
                    var theme4 = 'light';
                    // ????
                    if (document.body.classList.contains('dark')) {
                        theme4 = 'dark-fill-font';
                    } else {
                        theme4 = 'light';
                    }
                    // ??????,??????????????
                    for (var i = 0; i < elementsFillFont.length; i++) {
                        // ????
                        var element = elementsFillFont[i];
                        if (theme4 === 'dark-fill-font') {
                            element.classList.add('dark-fill-font');
                            element.classList.remove('light');
                        } else if (theme4 === 'light') {
                            element.classList.add('light');
                            element.classList.remove('dark-fill-font');
                        }
                    }
                    // ?????????????
                    // sessionStorage.setItem('theme4', theme4);




                    // ?? iframe ?? ? ????????
                    var savedTheme5 = sessionStorage.getItem('theme5');
                    var black= 'light'
                    if (iframe) {
                        styleElem = iframeDoc.createElement('style');
                    }
                    if (savedTheme5 !== null) {
                        if (savedTheme5 ==='dark') {
                            black= 'light'
                        }else {
                            black= 'dark'
                        }
                        if (black === 'dark') {
                            // // ?? iframe ??
                            // var iframe = document.getElementById('shell-iframe');
                            // // ?? iframe ?????
                            // var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
                            if (iframe) {
                                // ?? iframe ?????? body ??
                                var iframeBody = iframeDoc.body;

                                // ?? body ??????????
                                iframeBody.style.backgroundColor = 'black';
                                iframeBody.style.color = '#a9a9a9';

                                // ?? summary ??
                                var summary = iframeDoc.getElementById('summary');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = 'black';
                                    summary.style.color = '#a9a9a9';
                                }

                                // ?? Configuration History?? #history-filter
                                var summary = iframeDoc.getElementById('history-filter-dialog');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = 'black';
                                    summary.style.color = '#a9a9a9';
                                }

                                // ?? #history-filter #history-filter
                                var summary = iframeDoc.getElementById('history-filter');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = '#202320';
                                    summary.style.color = '#a9a9a9';
                                    summary.style.border = '0px solid #eaeef0';

                                }
                                // ?? #history-filter-start-date
                                var summary = iframeDoc.getElementById('history-filter-start-date');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = '#202320';
                                    summary.style.color = '#a9a9a9';
                                    summary.style.border = '0px solid #eaeef0';
                                }
                                // ?? #history-filter-start-time
                                var summary = iframeDoc.getElementById('history-filter-start-time');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = '#202320';
                                    summary.style.color = '#a9a9a9';
                                    summary.style.border = '0px solid #eaeef0';
                                }
                                // ?? #history-filter-end-date
                                var summary = iframeDoc.getElementById('history-filter-end-date');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = '#202320';
                                    summary.style.color = '#a9a9a9';
                                    summary.style.border = '0px solid #eaeef0';
                                }
                                // ?? #history-filter-end-time
                                var summary = iframeDoc.getElementById('history-filter-end-time');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = '#202320';
                                    summary.style.color = '#a9a9a9';
                                    summary.style.border = '0px solid #eaeef0';
                                }
                                // ?? #history-table
                                var historyTable = iframeDoc.getElementById('history-table');
                                if (historyTable) {
                                    historyTable.style.border = '1px solid #3d3d3d';
                                }

                                // ?? summary-tabs ??
                                var summaryTabs = iframeDoc.getElementById('summary-tabs');
                                if (summaryTabs) {
                                    // ?? summary-tabs ??????????,??????
                                    summaryTabs.style.backgroundColor = 'black';
                                    summaryTabs.style.color = '#a9a9a9';
                                }
                                var countersTable = iframeDoc.getElementById('counters-table');
                                if (countersTable) {
                                    countersTable.style.border = '1px solid #3d3d3d';
                                }var provenanceTable = iframeDoc.getElementById('provenance-table');
                                if (provenanceTable) {
                                    provenanceTable.style.border = '1px solid #3d3d3d';
                                }

                                var controllerServicesTable = iframeDoc.getElementById('controller-services-table');
                                if (controllerServicesTable) {
                                    controllerServicesTable.style.border = '1px solid #3d3d3d';
                                }var reportingTasksTable = iframeDoc.getElementById('reporting-tasks-table');
                                if (reportingTasksTable) {
                                    reportingTasksTable.style.border = '1px solid #3d3d3d';
                                }var templatesTable = iframeDoc.getElementById('templates-table');
                                if (templatesTable) {
                                    templatesTable.style.border = '1px solid #3d3d3d';
                                }var parameterProvidersTable = iframeDoc.getElementById('parameter-providers-table');
                                if (parameterProvidersTable) {
                                    parameterProvidersTable.style.border = '1px solid #3d3d3d';
                                }



                                // ??  summary-table ??
                                var summaryTabs2 = iframeDoc.querySelector('.summary-table');
                                if (summaryTabs2) {
                                    // ?? summary-tabs ??????????,??????
                                    summaryTabs2.style.backgroundColor = 'black';
                                    summaryTabs2.style.color = '#a9a9a9';
                                }
                                // ??  .slick-pane ??
                                var summaryTabs3 = iframeDoc.querySelector('.slick-pane');
                                if (summaryTabs3) {
                                    // ?? summary-tabs ??????????,??????
                                    summaryTabs3.style.backgroundColor = 'black';
                                    summaryTabs3.style.color = '#a9a9a9';
                                }
                                // ?????????
                                // styleElem.sheet.deleteRule(0);
                                //??css??????????????
                                // var styleElem = iframeDoc.createElement('style');
                                iframeDoc.head.appendChild(styleElem);
                                // ??????????????
                                styleElem.sheet.insertRule('.slick-cell, .slick-headerrow-column { background-color: black; color: #a9a9a9; }', 0);

                                // ??????????????
                                styleElem.sheet.insertRule('.slick-header-column.ui-state-default { background-color: #202320; color: #a9a9a9; }', 0);

                                // ??????????????
                                styleElem.sheet.insertRule('div.combo-button-normal { background-color: #202320 !important; color: #a9a9a9; }', 0);
                                // ??????????????
                                styleElem.sheet.insertRule('.tab { background-color: #202320; border: 1px solid #3d3d3d;}', 0);
                                // ??????????????
                                styleElem.sheet.insertRule('.tab, .tab button { color: #a9a9a9; }', 0);
                                // ??????????????
                                styleElem.sheet.insertRule('.slick-pane { background-color: black; color: #a9a9a9; }', 0);
                                // ??????????????
                                styleElem.sheet.insertRule('.combo { border: 1px solid #3d3d3d;}', 0);
                                styleElem.sheet.insertRule('div.summary-table { border: 1px solid #3d3d3d;}', 0);
                                styleElem.sheet.insertRule('.slick-cell, .slick-headerrow-column { border-left: 1px solid #3d3d3d; border-bottom: 1px solid #3d3d3d;}', 0);
                                styleElem.sheet.insertRule('.combo-option-text .tab button { color: #a9a9a9; }', 0);
                                styleElem.sheet.insertRule('.combo-option-text { color: white !important; }', 0);
                                // ??????????????
                                styleElem.sheet.insertRule('.combo-options ul > li { background-color: #202320 !important; }', 0);
                                var options = $(iframeDoc).find('.combo-options ul > li');
                                if (options) {
                                    options.hover(function () {
                                        // ??????????
                                        $(this).addClass('pointer').css('background', '#adadad !important');
                                    }, function () {
                                        // ??????????
                                        $(this).removeClass('pointer').css('background', '#202320 !important');
                                    });
                                }
                                //Counters->Filter???
                                styleElem.sheet.insertRule('input.filter { background-color: #202320; border: 0px solid #eaeef0;}', 0);
                                // ??????????????Counters->Filter table?
                                styleElem.sheet.insertRule('.slick-header-column.ui-state-default { background-color: #202320; color: #a9a9a9; }', 0);


                                //Templates*
                                // .dialog-header???? , .dialog, .dialog-header
                                // .dialog??
                                styleElem.sheet.insertRule('.dialog { background-color: black; }', 0);
                                styleElem.sheet.insertRule('.dialog-header { background-color: black; color: #a9a9a9; }', 0);
                                styleElem.sheet.insertRule('#reporting-tasks-table, #flow-analysis-rules-table, #registries-table, #parameter-contexts-table, #templates-table { border: 1px solid #3d3d3d; }', 0);
                                styleElem.sheet.insertRule('#controller-services-table { border: 1px solid #3d3d3d; }', 0);
                            }
                            // ?????????????
                            sessionStorage.setItem('theme5', black);
                        } else if (black === 'light') {
                            // // ?? iframe ??
                            // var iframe = document.getElementById('shell-iframe');
                            // // ?? iframe ?????
                            // var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
                            if (iframe) {
                                // ?? iframe ?????? body ??
                                var iframeBody = iframeDoc.body;

                                // ?? body ??????????
                                iframeBody.style.backgroundColor = 'white';
                                iframeBody.style.color = 'black';

                                // ?? summary ??
                                var summary = iframeDoc.getElementById('summary');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = 'white';
                                    summary.style.color = 'black';
                                }
                                // ?? summary-tabs ??
                                var summaryTabs = iframeDoc.getElementById('summary-tabs');
                                if (summaryTabs) {
                                    // ?? summary-tabs ??????????,??????
                                    summaryTabs.style.backgroundColor = 'white';
                                    summaryTabs.style.color = 'black';
                                }

                                // ?? Configuration History?? #history-filter
                                var summary = iframeDoc.getElementById('history-filter-dialog');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = 'white';
                                    summary.style.color = 'black';
                                }

                                // ?? #history-filter #history-filter
                                var summary = iframeDoc.getElementById('history-filter');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = '#F3F3F3';
                                    summary.style.color = 'black';
                                    summary.style.border = '1px solid #eaeef0';
                                }
                                // ?? #history-filter-start-date
                                var summary = iframeDoc.getElementById('history-filter-start-date');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = '#F3F3F3';
                                    summary.style.color = 'black';
                                    summary.style.border = '1px solid #eaeef0';
                                }
                                // ?? #history-filter-start-time
                                var summary = iframeDoc.getElementById('history-filter-start-time');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = '#F3F3F3';
                                    summary.style.color = 'black';
                                    summary.style.border = '1px solid #eaeef0';
                                }
                                // ?? #history-filter-end-date
                                var summary = iframeDoc.getElementById('history-filter-end-date');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = '#F3F3F3';
                                    summary.style.color = 'black';
                                    summary.style.border = '1px solid #eaeef0';
                                }
                                // ?? #history-filter-end-time
                                var summary = iframeDoc.getElementById('history-filter-end-time');
                                if (summary) {
                                    // ?? summary ??????????,??????
                                    summary.style.backgroundColor = '#F3F3F3';
                                    summary.style.color = 'black';
                                    summary.style.border = '1px solid #eaeef0';
                                }
                                // ?? #history-table
                                var historyTable = iframeDoc.getElementById('history-table');
                                if (historyTable) {
                                    historyTable.style.border = '1px solid #ccc';
                                }

                                var countersTable = iframeDoc.getElementById('counters-table');
                                if (countersTable) {
                                    countersTable.style.border = '1px solid #ccc';
                                }var provenanceTable = iframeDoc.getElementById('provenance-table');
                                if (provenanceTable) {
                                    provenanceTable.style.border = '1px solid #ccc';
                                }

                                var controllerServicesTable = iframeDoc.getElementById('controller-services-table');
                                if (controllerServicesTable) {
                                    controllerServicesTable.style.border = '1px solid #ccc';
                                }var reportingTasksTable = iframeDoc.getElementById('reporting-tasks-table');
                                if (reportingTasksTable) {
                                    reportingTasksTable.style.border = '1px solid #ccc';
                                }var templatesTable = iframeDoc.getElementById('templates-table');
                                if (templatesTable) {
                                    templatesTable.style.border = '1px solid #ccc';
                                }var parameterProvidersTable = iframeDoc.getElementById('parameter-providers-table');
                                if (parameterProvidersTable) {
                                    parameterProvidersTable.style.border = '1px solid #ccc';
                                }


                                // ??  summary-table ??
                                var summaryTabs2 = iframeDoc.querySelector('.summary-table');
                                if (summaryTabs2) {
                                    // ?? summary-tabs ??????????,??????
                                    summaryTabs2.style.backgroundColor = 'white';
                                    summaryTabs2.style.color = 'black';
                                }
                                // ??  .slick-pane ??
                                var summaryTabs3 = iframeDoc.querySelector('.slick-pane');
                                if (summaryTabs3) {
                                    // ?? summary-tabs ??????????,??????
                                    summaryTabs3.style.backgroundColor = 'white';
                                    summaryTabs3.style.color = 'black';
                                }
                                // // ?????????
                                // styleElem.sheet.deleteRule(0);
                                // ????????? onPageLoaded() ??
                                // window.onPageLoaded()
                                if (iframe) {
                                    // // ?? iframe ?????? body ??
                                    // var iframeBody = iframeDoc.body;
                                    //
                                    // // ?? body ??????????
                                    // iframeBody.style.backgroundColor = 'black';
                                    // iframeBody.style.color = 'white';
                                    //
                                    // // ?? summary ??
                                    // var summary = iframeDoc.getElementById('summary');
                                    // // ?? summary ??????????,??????
                                    // summary.style.backgroundColor = 'black';
                                    // summary.style.color = 'white';
                                    // // ?? summary-tabs ??
                                    // var summaryTabs = iframeDoc.getElementById('summary-tabs');
                                    // // ?? summary-tabs ??????????,??????
                                    // summaryTabs.style.backgroundColor = 'black';
                                    // summaryTabs.style.color = 'white';
                                    //
                                    //
                                    // // ??  summary-table ??
                                    // var summaryTabs2 = iframeDoc.querySelector('.summary-table');
                                    // // ?? summary-tabs ??????????,??????
                                    // summaryTabs2.style.backgroundColor = 'black';
                                    // summaryTabs2.style.color = 'white';

                                    // ?????????
                                    // styleElem.sheet.deleteRule(0);
                                    //??css??????????????
                                    // var styleElem = iframeDoc.createElement('style');
                                    iframeDoc.head.appendChild(styleElem);
                                    // ??????????????
                                    styleElem.sheet.insertRule('.slick-cell, .slick-headerrow-column { background-color: white; color: black; }', 0);

                                    // ??????????????
                                    styleElem.sheet.insertRule('.slick-header-column.ui-state-default { background-color: #f9f6fe; color: black; }', 0);

                                    // ??????????????
                                    styleElem.sheet.insertRule('div.combo-button-normal { background-color: #f3f3f3 !important; color: black; }', 0);
                                    // ??????????????
                                    styleElem.sheet.insertRule('.tab { background-color: #f1ebfd; border: 1px solid #ccdadb;}', 0);
                                    // ??????????????
                                    styleElem.sheet.insertRule('.tab, .tab button { color: black; }', 0);
                                    // ??????????????
                                    styleElem.sheet.insertRule('.slick-pane { background-color: white; color: black; }', 0);

                                    // ??????????????
                                    styleElem.sheet.insertRule('.combo { border: 1px solid #eaeef0;}', 0);
                                    styleElem.sheet.insertRule('div.summary-table { border: 1px solid #e5e4e7;}', 0);
                                    styleElem.sheet.insertRule('.slick-cell, .slick-headerrow-column { border-left: 1px solid #c7d2d7; border-bottom: 1px solid #c7d2d7;}', 0);
                                    styleElem.sheet.insertRule('.combo-option-text .tab button { color: black; }', 0);
                                    styleElem.sheet.insertRule('.combo-option-text { color: black !important; }', 0);
                                    // ??????????????
                                    styleElem.sheet.insertRule('.combo-options ul > li { background-color: #f3f3f3 !important; }', 0);
                                    var options = $(iframeDoc).find('.combo-options ul > li');
                                    if (options) {
                                        options.hover(function () {
                                            // ??????????
                                            $(this).addClass('pointer').css('background', '#eaeef0 !important');
                                        }, function () {
                                            // ??????????
                                            $(this).removeClass('pointer').css('background', 'white !important');
                                        });
                                    }
                                    //Counters->Filter???
                                    styleElem.sheet.insertRule('input.filter { background-color: #f3f3f3; border: 1px solid #eaeef0;}', 0);
                                    // ??????????????Counters->Filter table?
                                    styleElem.sheet.insertRule('.slick-header-column.ui-state-default { background-color: #f9f6fe; color: black; }', 0);
                                    //Templates*
                                    // .dialog-header???? , .dialog, .dialog-header
                                    // .dialog??
                                    styleElem.sheet.insertRule('.dialog { background-color: white; }', 0);
                                    styleElem.sheet.insertRule('.dialog-header { background-color: white; color: black; }', 0);
                                    styleElem.sheet.insertRule('#reporting-tasks-table, #flow-analysis-rules-table, #registries-table, #parameter-contexts-table, #templates-table { border: 1px solid #ccc; }', 0);
                                    styleElem.sheet.insertRule('#controller-services-table { border: 1px solid #ccc; }', 0);
                                }

                            }
                            // ?????????????
                            sessionStorage.setItem('theme5', black);

                        }
                    }else {
                        // ?????????
                        black= 'dark'
                        // // ?? iframe ??
                        // var iframe = document.getElementById('shell-iframe');
                        // // ?? iframe ?????
                        // var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
                        if (iframe) {
                            // ?? iframe ?????? body ??
                            var iframeBody = iframeDoc.body;

                            // ?? body ??????????
                            iframeBody.style.backgroundColor = 'black';
                            iframeBody.style.color = '#a9a9a9';

                            // ?? summary ??
                            var summary = iframeDoc.getElementById('summary');
                            if (summary) {
                                // ?? summary ??????????,??????
                                summary.style.backgroundColor = 'black';
                                summary.style.color = '#a9a9a9';
                            }
                            // ?? summary-tabs ??
                            var summaryTabs = iframeDoc.getElementById('summary-tabs');
                            if (summaryTabs) {
                                // ?? summary-tabs ??????????,??????
                                summaryTabs.style.backgroundColor = 'black';
                                summaryTabs.style.color = '#a9a9a9';
                            }

                            // ?? Configuration History?? #history-filter
                            var summary = iframeDoc.getElementById('history-filter-dialog');
                            if (summary) {
                                // ?? summary ??????????,??????
                                summary.style.backgroundColor = 'black';
                                summary.style.color = '#a9a9a9';
                            }

                            // ?? #history-filter #history-filter
                            var summary = iframeDoc.getElementById('history-filter');
                            if (summary) {
                                // ?? summary ??????????,??????
                                summary.style.backgroundColor = '#202320';
                                summary.style.color = '#a9a9a9';
                                summary.style.border = '0px solid #eaeef0';
                            }
                            // ?? #history-filter-start-date
                            var summary = iframeDoc.getElementById('history-filter-start-date');
                            if (summary) {
                                // ?? summary ??????????,??????
                                summary.style.backgroundColor = '#202320';
                                summary.style.color = '#a9a9a9';
                                summary.style.border = '0px solid #eaeef0';
                            }
                            // ?? #history-filter-start-time
                            var summary = iframeDoc.getElementById('history-filter-start-time');
                            if (summary) {
                                // ?? summary ??????????,??????
                                summary.style.backgroundColor = '#202320';
                                summary.style.color = '#a9a9a9';
                                summary.style.border = '0px solid #eaeef0';
                            }
                            // ?? #history-filter-end-date
                            var summary = iframeDoc.getElementById('history-filter-end-date');
                            if (summary) {
                                // ?? summary ??????????,??????
                                summary.style.backgroundColor = '#202320';
                                summary.style.color = '#a9a9a9';
                                summary.style.border = '0px solid #eaeef0';
                            }
                            // ?? #history-filter-end-time
                            var summary = iframeDoc.getElementById('history-filter-end-time');
                            if (summary) {
                                // ?? summary ??????????,??????
                                summary.style.backgroundColor = '#202320';
                                summary.style.color = '#a9a9a9';
                                summary.style.border = '0px solid #eaeef0';
                            }
                            // ?? #history-table
                            var historyTable = iframeDoc.getElementById('history-table');
                            if (historyTable) {
                                historyTable.style.border = '1px solid #3d3d3d';
                            }

                            var countersTable = iframeDoc.getElementById('counters-table');
                            if (countersTable) {
                                countersTable.style.border = '1px solid #3d3d3d';
                            }var provenanceTable = iframeDoc.getElementById('provenance-table');
                            if (provenanceTable) {
                                provenanceTable.style.border = '1px solid #3d3d3d';
                            }

                            var controllerServicesTable = iframeDoc.getElementById('controller-services-table');
                            if (controllerServicesTable) {
                                controllerServicesTable.style.border = '1px solid #3d3d3d';
                            }var reportingTasksTable = iframeDoc.getElementById('reporting-tasks-table');
                            if (reportingTasksTable) {
                                reportingTasksTable.style.border = '1px solid #3d3d3d';
                            }var templatesTable = iframeDoc.getElementById('templates-table');
                            if (templatesTable) {
                                templatesTable.style.border = '1px solid #3d3d3d';
                            }var parameterProvidersTable = iframeDoc.getElementById('parameter-providers-table');
                            if (parameterProvidersTable) {
                                parameterProvidersTable.style.border = '1px solid #3d3d3d';
                            }



                            // ??  summary-table ??
                            var summaryTabs2 = iframeDoc.querySelector('.summary-table');
                            if (summaryTabs2) {
                                // ?? summary-tabs ??????????,??????
                                summaryTabs2.style.backgroundColor = 'black';
                                summaryTabs2.style.color = '#a9a9a9';
                            }
                            // ??  .slick-pane ??
                            var summaryTabs3 = iframeDoc.querySelector('.slick-pane');
                            if (summaryTabs3) {
                                // ?? summary-tabs ??????????,??????
                                summaryTabs3.style.backgroundColor = 'black';
                                summaryTabs3.style.color = '#a9a9a9';
                            }
                            // ?????????
                            // styleElem.sheet.deleteRule(0);
                            //??css??????????????
                            // var styleElem = iframeDoc.createElement('style');
                            iframeDoc.head.appendChild(styleElem);
                            // ??????????????
                            styleElem.sheet.insertRule('.slick-cell, .slick-headerrow-column { background-color: black; color: #a9a9a9; }', 0);
                            // ??????????????
                            styleElem.sheet.insertRule('.slick-header-column.ui-state-default { background-color: #202320; color: #a9a9a9; }', 0);
                            // ??????????????
                            styleElem.sheet.insertRule('div.combo-button-normal { background-color: #202320 !important; color: #a9a9a9; }', 0);
                            // ??????????????
                            styleElem.sheet.insertRule('.tab { background-color: #202320; border: 1px solid #3d3d3d;}', 0);
                            // ??????????????
                            styleElem.sheet.insertRule('.tab, .tab button { color: #a9a9a9; }', 0);
                            // ??????????????
                            styleElem.sheet.insertRule('.slick-pane { background-color: black; color: #a9a9a9; }', 0);
                            // ??????????????
                            styleElem.sheet.insertRule('.combo { border: 1px solid #3d3d3d;}', 0);
                            styleElem.sheet.insertRule('div.summary-table { border: 1px solid #3d3d3d;}', 0);
                            styleElem.sheet.insertRule('.slick-cell, .slick-headerrow-column { border-left: 1px solid #3d3d3d; border-bottom: 1px solid #3d3d3d;}', 0);
                            styleElem.sheet.insertRule('.combo-option-text .tab button { color: #a9a9a9; }', 0);
                            styleElem.sheet.insertRule('.combo-option-text { color: white !important; }', 0);
                            // ??????????????
                            styleElem.sheet.insertRule('.combo-options ul > li { background-color: #202320 !important; }', 0);
                            var options = $(iframeDoc).find('.combo-options ul > li');
                            if (options) {
                                options.hover(function () {
                                    // ??????????
                                    $(this).addClass('pointer').css('background', '#adadad !important');
                                }, function () {
                                    // ??????????
                                    $(this).removeClass('pointer').css('background', '#202320 !important');
                                });
                            }
                            //Counters->Filter???
                            styleElem.sheet.insertRule('input.filter { background-color: #202320; border: 0px solid #eaeef0;}', 0);
                            // ??????????????Counters->Filter table?
                            styleElem.sheet.insertRule('.slick-header-column.ui-state-default { background-color: #202320; color: #a9a9a9; }', 0);

                            //Templates*
                            // .dialog-header???? , .dialog, .dialog-header
                            // .dialog??
                            styleElem.sheet.insertRule('.dialog { background-color: black; }', 0);
                            styleElem.sheet.insertRule('.dialog-header { background-color: black; color: #a9a9a9; }', 0);
                            styleElem.sheet.insertRule('#reporting-tasks-table, #flow-analysis-rules-table, #registries-table, #parameter-contexts-table, #templates-table { border: 1px solid #3d3d3d; }', 0);
                            styleElem.sheet.insertRule('#controller-services-table { border: 1px solid #3d3d3d; }', 0);
                            // // ?????????
                            // styleElem.sheet.deleteRule(0);
                        }

                        // ?????????????
                        sessionStorage.setItem('theme5', black);
                    }
                },


                /**
                 * Toggle/Slide the search field open/closed.
                 */
                toggleSearchField: function () {
                    var searchCtrl = this;

                    // hide the context menu if necessary
                    nfContextMenu.hide();

                    var isVisible = searchCtrl.getInputElement().is(':visible');
                    var display = 'block';
                    var class1 = 'search-container-opened';
                    var class2 = 'search-container-closed';
                    if (!isVisible) {
                        searchCtrl.getButtonElement().css('background-color', '#FFFFFF');
                        display = 'inline-block';
                        class1 = 'search-container-closed';
                        class2 = 'search-container-opened';
                    } else {
                        searchCtrl.getInputElement().css('display', display);
                    }

                    this.getSearchContainerElement().switchClass(class1, class2, 500, function () {
                        searchCtrl.getInputElement().css('display', display);
                        if (!isVisible) {
                            searchCtrl.getButtonElement().css('background-color', '#FFFFFF');
                            searchCtrl.getInputElement().focus();
                        } else {
                            searchCtrl.getButtonElement().css('background-color', '#E3E8EB');
                        }
                    });
                }
            }

            /**
             * The bulletins controller.
             */
            this.bulletins = {

                /**
                 * Update the bulletins.
                 *
                 * @param response  The controller bulletins returned from the `../nifi-api/controller/bulletins` endpoint.
                 */
                update: function (response) {

                    // icon for system bulletins
                    var bulletinIcon = $('#bulletin-button');
                    var currentBulletins = bulletinIcon.data('bulletins');

                    // update the bulletins if necessary
                    if (nfCommon.doBulletinsDiffer(currentBulletins, response.bulletins)) {
                        bulletinIcon.data('bulletins', response.bulletins);

                        // get the formatted the bulletins
                        var bulletins = nfCommon.getFormattedBulletins(response.bulletins);

                        // bulletins for this processor are now gone
                        if (bulletins.length === 0) {
                            if (bulletinIcon.data('qtip')) {
                                bulletinIcon.removeClass('has-bulletins').qtip('api').destroy(true);
                            }
                        } else {
                            var newBulletins = nfCommon.formatUnorderedList(bulletins);

                            // different bulletins, refresh
                            if (bulletinIcon.data('qtip')) {
                                bulletinIcon.qtip('option', 'content.text', newBulletins);
                            } else {
                                // no bulletins before, show icon and tips
                                bulletinIcon.addClass('has-bulletins').qtip($.extend({},
                                    nfCanvasUtils.config.systemTooltipConfig,
                                    {
                                        content: newBulletins,
                                        position: {
                                            at: 'bottom left',
                                            my: 'top right',
                                            adjust: {
                                                x: 4
                                            }
                                        }
                                    }
                                ));
                            }
                        }
                    }

                    // update controller service and reporting task bulletins
                    nfSettings.setBulletins(response.controllerServiceBulletins, response.reportingTaskBulletins);
                }

            }
        }

        FlowStatusCtrl.prototype = {
            constructor: FlowStatusCtrl,

            /**
             * Initialize the flow status controller.
             */
            init: function () {
                this.search.init();
            },

            /**
             * Reloads the current status of the flow.
             */
            reloadFlowStatus: function () {
                var flowStatusCtrl = this;

                return $.ajax({
                    type: 'GET',
                    url: config.urls.status,
                    dataType: 'json'
                }).done(function (response) {
                    // report the updated status
                    if (nfCommon.isDefinedAndNotNull(response.controllerStatus)) {
                        flowStatusCtrl.update(response.controllerStatus);
                    }
                }).fail(nfErrorHandler.handleAjaxError);
            },

            /**
             * Updates the cluster summary.
             *
             * @param summary
             */
            updateClusterSummary: function (summary) {
                // update the connection state
                if (summary.connectedToCluster) {
                    var connectedNodes = summary.connectedNodes.split(' / ');
                    if (connectedNodes.length === 2 && connectedNodes[0] !== connectedNodes[1]) {
                        this.clusterConnectionWarning = true;
                    } else {
                        this.clusterConnectionWarning = false;
                    }
                    this.connectedNodesCount = summary.connectedNodes;
                } else {
                    this.connectedNodesCount = 'Disconnected';
                }
            },

            /**
             * Returns whether there are any terminated threads.
             *
             * @returns {boolean} whether there are any terminated threads
             */
            hasTerminatedThreads: function () {
                if (Number.isInteger(this.terminatedThreadCount)) {
                    return this.terminatedThreadCount > 0;
                } else {
                    return false;
                }
            },

            /**
             * Returns any additional styles to apply to the thread counts.
             *
             * @returns {string}
             */
            getExtraThreadStyles: function () {
                if (Number.isInteger(this.terminatedThreadCount) && this.terminatedThreadCount > 0) {
                    return 'warning';
                } else if (this.activeThreadCount === 0) {
                    return 'zero';
                }

                return '';
            },

            /**
             * Returns any additional styles to apply to the cluster label.
             *
             * @returns {string}
             */
            getExtraClusterStyles: function () {
                if (this.connectedNodesCount === 'Disconnected' || this.clusterConnectionWarning === true) {
                    return 'warning';
                }

                return '';
            },

            /**
             * Update the flow status counts.
             *
             * @param status  The controller status returned from the `../nifi-api/flow/status` endpoint.
             */
            update: function (status) {
                // update the report values
                this.activeThreadCount = status.activeThreadCount;
                this.terminatedThreadCount = status.terminatedThreadCount;

                if (this.hasTerminatedThreads()) {
                    this.threadCounts = this.activeThreadCount + ' (' + this.terminatedThreadCount + ')';
                } else {
                    this.threadCounts = this.activeThreadCount;
                }

                this.totalQueued = status.queued;

                if (this.totalQueued.indexOf('0 / 0') >= 0) {
                    $('#flow-status-container').find('.fa-list').addClass('zero');
                } else {
                    $('#flow-status-container').find('.fa-list').removeClass('zero');
                }

                // update the component counts
                this.controllerTransmittingCount =
                    nfCommon.isDefinedAndNotNull(status.activeRemotePortCount) ?
                        status.activeRemotePortCount : '-';

                if (this.controllerTransmittingCount > 0) {
                    $('#flow-status-container').find('.fa-bullseye').removeClass('zero').addClass('transmitting');
                } else {
                    $('#flow-status-container').find('.fa-bullseye').removeClass('transmitting').addClass('zero');
                }

                this.controllerNotTransmittingCount =
                    nfCommon.isDefinedAndNotNull(status.inactiveRemotePortCount) ?
                        status.inactiveRemotePortCount : '-';

                if (this.controllerNotTransmittingCount > 0) {
                    $('#flow-status-container').find('.icon-transmit-false').removeClass('zero').addClass('not-transmitting');
                } else {
                    $('#flow-status-container').find('.icon-transmit-false').removeClass('not-transmitting').addClass('zero');
                }

                this.controllerRunningCount =
                    nfCommon.isDefinedAndNotNull(status.runningCount) ? status.runningCount : '-';

                if (this.controllerRunningCount > 0) {
                    $('#flow-status-container').find('.fa-play').removeClass('zero').addClass('running');
                } else {
                    $('#flow-status-container').find('.fa-play').removeClass('running').addClass('zero');
                }

                this.controllerStoppedCount =
                    nfCommon.isDefinedAndNotNull(status.stoppedCount) ? status.stoppedCount : '-';

                if (this.controllerStoppedCount > 0) {
                    $('#flow-status-container').find('.fa-stop').removeClass('zero').addClass('stopped');
                } else {
                    $('#flow-status-container').find('.fa-stop').removeClass('stopped').addClass('zero');
                }

                this.controllerInvalidCount =
                    nfCommon.isDefinedAndNotNull(status.invalidCount) ? status.invalidCount : '-';

                if (this.controllerInvalidCount > 0) {
                    $('#flow-status-container').find('.fa-warning').removeClass('zero').addClass('invalid');
                } else {
                    $('#flow-status-container').find('.fa-warning').removeClass('invalid').addClass('zero');
                }

                this.controllerDisabledCount =
                    nfCommon.isDefinedAndNotNull(status.disabledCount) ? status.disabledCount : '-';

                if (this.controllerDisabledCount > 0) {
                    $('#flow-status-container').find('.icon-enable-false').removeClass('zero').addClass('disabled');
                } else {
                    $('#flow-status-container').find('.icon-enable-false').removeClass('disabled').addClass('zero');
                }

                this.controllerUpToDateCount =
                    nfCommon.isDefinedAndNotNull(status.upToDateCount) ? status.upToDateCount : '-';

                if (this.controllerUpToDateCount > 0) {
                    $('#flow-status-container').find('.fa-check').removeClass('zero').addClass('up-to-date');
                } else {
                    $('#flow-status-container').find('.fa-check').removeClass('up-to-date').addClass('zero');
                }

                this.controllerLocallyModifiedCount =
                    nfCommon.isDefinedAndNotNull(status.locallyModifiedCount) ? status.locallyModifiedCount : '-';

                if (this.controllerLocallyModifiedCount > 0) {
                    $('#flow-status-container').find('.fa-asterisk').removeClass('zero').addClass('locally-modified');
                } else {
                    $('#flow-status-container').find('.fa-asterisk').removeClass('locally-modified').addClass('zero');
                }

                this.controllerStaleCount =
                    nfCommon.isDefinedAndNotNull(status.staleCount) ? status.staleCount : '-';

                if (this.controllerStaleCount > 0) {
                    $('#flow-status-container').find('.fa-arrow-circle-up').removeClass('zero').addClass('stale');
                } else {
                    $('#flow-status-container').find('.fa-arrow-circle-up').removeClass('stale').addClass('zero');
                }

                this.controllerLocallyModifiedAndStaleCount =
                    nfCommon.isDefinedAndNotNull(status.locallyModifiedAndStaleCount) ? status.locallyModifiedAndStaleCount : '-';

                if (this.controllerLocallyModifiedAndStaleCount > 0) {
                    $('#flow-status-container').find('.fa-exclamation-circle').removeClass('zero').addClass('locally-modified-and-stale');
                } else {
                    $('#flow-status-container').find('.fa-exclamation-circle').removeClass('locally-modified-and-stale').addClass('zero');
                }

                this.controllerSyncFailureCount =
                    nfCommon.isDefinedAndNotNull(status.syncFailureCount) ? status.syncFailureCount : '-';

                if (this.controllerSyncFailureCount > 0) {
                    $('#flow-status-container').find('.fa-question').removeClass('zero').addClass('sync-failure');
                } else {
                    $('#flow-status-container').find('.fa-question').removeClass('sync-failure').addClass('zero');
                }

            },

            /**
             * Updates the controller level bulletins
             *
             * @param response
             */
            updateBulletins: function (response) {
                this.bulletins.update(response);
            }
        }

        var flowStatusCtrl = new FlowStatusCtrl();
        return flowStatusCtrl;
    };
}));
// ????????????
window.onload = function() {
    // ????????
    setTimeout(function() {
        // ??????????????
        onPageLoaded(); // ????????????
    }, 2000); // 2000??,?2?????
}
// document.addEventListener('click', function(event) {
//     // ????????
//     onPageLoaded(); // ????????????
// });
// document.addEventListener('drag', function(event) {
//     // ??????
//     onPageLoaded(); // ????????????
// });
// document.addEventListener('mouseup', function(event) {
//     // ????????
//     onPageLoaded(); // ????????????
// });
// // ? onPageLoaded() ????? window ???
// window.onPageLoaded = onPageLoaded;
function onPageLoaded(){
    console.log('??????');
    // $(document).ready(function() {
    //     // ?Cancel????ID
    //     console.log('???Cancel??');
    //     var cancelBtn = $('button:contains("Cancel")'); // ?????? "Cancel" ???
    //     // cancelBtn.attr('id', 'cc');
    //     $('#processor-configuration').hide()
    // });
    // ?????????????????????

    const elements = document.querySelectorAll('body.aa, #process-group-configuration, div.summary-table, #flow-status2, .graph-control button, #graph-controls .icon, #data-flow-title-viewport, #breadcrumbs, .theme-element, #canvas-body, .global-menu-open, .layout-align-space-between-end, #current-user, #shell-dialog, #search-container, #shell-container, #counters, summary-table, .slick-cell, .slick-headerrow-column, div.summary-table, .slick-header-column.ui-state-default, .slick-row.ui-widget-content, .slick-row.ui-state-active, #summary, #aa, .aa, body, #summary-tabs, body.md-default-theme, html.md-default-theme, html, div[id$="-tabs-content"], .grid-canvas, #flow-summary-refresh-container, .large-dialog, .dialog-header, #new-port-dialog, #new-process-group-dialog, .dialog, .setting-name, g.connection path.connection-path, .dialog, .dialog-header, .dialog-status-bar, #global-menu-content a, div.context-menu-item-text, #prioritizer-available, #prioritizer-selected, .CodeMirror-scroll, .slickgrid-nf-editor');//.slick-cell, .slick-headerrow-column

    // ?????????????????????
    var savedTheme = sessionStorage.getItem('theme');
    if (savedTheme !== null) {
        if (savedTheme === 'dark') {
            for (var i = 0; i < elements.length; i++) {
                var element = elements[i];
                element.classList.add('dark');
                element.classList.remove('light');
            }
        } else {
            // document.getElementById('shell-iframe')//???iframe
            //     .contentWindow//???iframe?window
            //     .document//???iframe?document
            //     .getElementById('summary')//??????
            //     .style.background="red"
            //     .style.color = "orange";//????


            for (var i = 0; i < elements.length; i++) {
                var element = elements[i];
                element.classList.add('light');
                element.classList.remove('dark');
            }
        }
    }
    //??????
    // ???????????,????????
    const elementsb = document.querySelectorAll('#global-menu-content, #flow-status');
    // ??????,??????????????
    for (var i = 0; i < elementsb.length; i++) {
        // ????
        var element = elementsb[i];
        if (savedTheme === 'dark') {
            element.classList.add('dark-b');
            element.classList.remove('light');
        } else if (savedTheme === 'light') {
            element.classList.add('light');
            element.classList.remove('dark-b');
        }
    }
    const elements2 = document.querySelectorAll('.bb, .combo-text, .icon-threads, .blue-border, #search-button, #canvas-container, #graph-control, .slick-header-column, textarea, #general-process-group-configuration input, #general-process-group-configuration textarea, #processor-comments, .tab, .tab button, input[type="text"], input[type="password"], input[type=text], input[type=password], #parameter-context-available, #parameter-context-selected');

    // var savedTheme2 = sessionStorage.getItem('theme2');
    if (savedTheme !== null) {
        if (savedTheme === 'dark') {
            for (var i = 0; i < elements2.length; i++) {
                var element = elements2[i];
                element.classList.add('dark2');
                element.classList.remove('light');
            }
        } else {
            for (var i = 0; i < elements2.length; i++) {
                var element = elements2[i];
                element.classList.add('light');
                element.classList.remove('dark2');
            }
        }
    }

    const elementsb2 = document.querySelectorAll(' #search-field, .search, .context-menu, #prioritizer-available li, #parameter-providers-table');
    // ??????,??????????????
    for (var i = 0; i < elementsb2.length; i++) {
        // ????
        var element = elementsb2[i];
        element.classList.remove('dark2');
        if (savedTheme === 'dark') {
            element.classList.add('dark-b2');
            element.classList.remove('light-search');
        } else if (savedTheme === 'light') {
            element.classList.add('light-search');
            element.classList.remove('dark-b2');
        }
    }
    const elements2b = document.querySelectorAll(' .graph-control')
    // ??????,??????????????
    for (var i = 0; i < elements2b.length; i++) {
        // ????
        var element = elements2b[i];
        if (savedTheme === 'dark') {
            element.classList.add('dark2-b');
            element.classList.remove('light');
        } else if (savedTheme === 'light') {
            element.classList.add('light');
            element.classList.remove('dark2-b');
        }
    }

    //Cancel ????
    const elementsC = document.querySelectorAll('.cc, #cc, .CodeMirror-gutters, div.secondary-button')//div.button,
        // ??????,??????????????
    for (var i = 0; i < elementsC.length; i++) {
        // ????
        var element = elementsC[i];
        if (savedTheme === 'dark') {
            element.classList.add('dark-button');
            element.classList.remove('light-button');
        } else if (savedTheme === 'light') {
            element.classList.add('light-button');
            element.classList.remove('dark-button');
        }
    }
    const elementsCb = document.querySelectorAll('div.button')//div.button,
    // ??????,??????????????
    for (var i = 0; i < elementsCb.length; i++) {
        // ????
        var element = elementsCb[i];
        if (savedTheme === 'dark') {
            element.classList.add('dark-button-b');
            element.classList.remove('light-button');
        } else if (savedTheme === 'light') {
            element.classList.add('light-button');
            element.classList.remove('dark-button-b');
        }
    }

    //table
    const elementsTable = document.querySelectorAll('#controller-services-table, #reporting-tasks-table, #flow-analysis-rules-table, #registries-table, #parameter-contexts-table, #templates-table')
    // ??????,??????????????
    for (var i = 0; i < elementsTable.length; i++) {
        // ????
        var element = elementsTable[i];
        if (savedTheme === 'dark') {
            element.classList.add('dark-table');
            element.classList.remove('light-table');
        } else if (savedTheme === 'light') {
            element.classList.add('light-table');
            element.classList.remove('dark-table');
        }
    }

    //?????iframe?css ???
    const elementsL = document.querySelectorAll('.combo, .combo-open')
    // ??????,??????????????
    for (var i = 0; i < elementsL.length; i++) {
        // ????
        var element = elementsL[i];
        if (savedTheme === 'dark') {
            element.classList.add('dark-l');
            element.classList.remove('light');
        } else if (savedTheme === 'light') {
            element.classList.add('light');
            element.classList.remove('dark-l');
        }
    }
    // const elements22 = document.querySelectorAll('.tab, .tab button, input[type="text"], input[type="password"]');
    //
    // var savedTheme22 = localStorage.getItem('theme2');
    // sessionStorage.
    // console.log(savedTheme22);
    // if (savedTheme22 !== null) {
    //     console.log(savedTheme22+"***!=null");
    //     if (savedTheme22 === 'dark22') {
    //         console.log(savedTheme22+"***=== 'dark22'");
    //         for (var i = 0; i < elements22.length; i++) {
    //             var element = elements22[i];
    //             element.classList.add('dark22');
    //             element.classList.remove('light');
    //         }
    //     } else {
    //         console.log(savedTheme22+"***!== 'dark22'");
    //         console.log(elements22.length+"***'elements2.length'");
    //         for (var i = 0; i < elements22.length; i++) {
    //             var element = elements22[i];
    //             element.classList.add('light');
    //             element.classList.remove('dark22');
    //         }
    //     }
    // }


    // ?????????????????????
    const elementsFill = document.querySelectorAll('.aa-fill');//, g.component rect.body

    // ?????????????????????
    // var savedTheme = sessionStorage.getItem('theme3');
    if (savedTheme !== null) {
        if (savedTheme === 'dark') {
            for (var i = 0; i < elementsFill.length; i++) {
                var element = elementsFill[i];
                element.classList.add('dark-fill');
                element.classList.remove('light');
            }
        } else {
            for (var i = 0; i < elementsFill.length; i++) {
                var element = elementsFill[i];
                element.classList.add('light');
                element.classList.remove('dark-fill');
            }
        }
    }



    // ?????????????????????
    const elementsFillFont = document.querySelectorAll('text.stats-label, text.port-name');

    // ?????????????????????
    // var savedTheme4 = sessionStorage.getItem('theme4');
    if (savedTheme !== null) {
        if (savedTheme === 'dark') {
            for (var i = 0; i < elementsFillFont.length; i++) {
                var element = elementsFillFont[i];
                element.classList.add('dark-fill-font');
                element.classList.remove('light');
            }
        } else {
            for (var i = 0; i < elementsFillFont.length; i++) {
                var element = elementsFillFont[i];
                element.classList.add('light');
                element.classList.remove('dark-fill-font');
            }
        }
    }


    // ?? iframe ?? ? ????????
    var savedTheme5 = sessionStorage.getItem('theme5');
    if (savedTheme5 !== null) {
        if (savedTheme5 === 'light') {
// ?? iframe ?????
            var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
            if (iframe) {
                // ?? iframe ?????? body ??
                var iframeBody = iframeDoc.body;

                // ?? body ??????????
                iframeBody.style.backgroundColor = 'white';
                iframeBody.style.color = 'black';

                // ?? summary ??
                var summary = iframeDoc.getElementById('summary');
                if (summary) {
                    // ?? summary ??????????,??????
                    summary.style.backgroundColor = 'white';
                    summary.style.color = 'black';
                }
                // ?? summary-tabs ??
                var summaryTabs = iframeDoc.getElementById('summary-tabs');
                if (summaryTabs) {
                    // ?? summary-tabs ??????????,??????
                    summaryTabs.style.backgroundColor = 'white';
                    summaryTabs.style.color = 'black';
                }
                // ??  summary-table ??
                var summaryTabs2 = iframeDoc.querySelector('.summary-table');
                if (summaryTabs2) {
                    // ?? summary-tabs ??????????,??????
                    summaryTabs2.style.backgroundColor = 'white';
                    summaryTabs2.style.color = 'black';
                }
                // ??  .slick-pane ??
                var summaryTabs3 = iframeDoc.querySelector('.slick-pane');
                if (summaryTabs3) {
                    // ?? summary-tabs ??????????,??????
                    summaryTabs3.style.backgroundColor = 'white';
                    summaryTabs3.style.color = 'black';
                }
                // ?????????
                // styleElem.sheet.deleteRule(0);
            }

        } else if (savedTheme5 === 'dark') {
            // ?? iframe ??
            var iframe = document.getElementById('shell-iframe');
            if (iframe) {
                // ?? iframe ?????
                var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
                // ?? iframe ?????? body ??
                var iframeBody = iframeDoc.body;

                // ?? body ??????????
                iframeBody.style.backgroundColor = 'black';
                iframeBody.style.color = '#a9a9a9';

                // ?? summary ??
                var summary = iframeDoc.getElementById('summary');
                if (summary) {
                    // ?? summary ??????????,??????
                    summary.style.backgroundColor = 'black';
                    summary.style.color = '#a9a9a9';
                }
                // ?? summary-tabs ??
                var summaryTabs = iframeDoc.getElementById('summary-tabs');
                if (summaryTabs) {
                    // ?? summary-tabs ??????????,??????
                    summaryTabs.style.backgroundColor = 'black';
                    summaryTabs.style.color = '#a9a9a9';
                }
                // ?? Configuration History?? #history-filter
                var summary = iframeDoc.getElementById('history-filter-dialog');
                if (summary) {
                    // ?? summary ??????????,??????
                    summary.style.backgroundColor = 'black';
                    summary.style.color = '#a9a9a9';
                }

                // ?? #history-filter #history-filter
                var summary = iframeDoc.getElementById('history-filter');
                if (summary) {
                    // ?? summary ??????????,??????
                    summary.style.backgroundColor = '#202320';
                    summary.style.color = '#a9a9a9';
                    summary.style.border = '0px solid #eaeef0';
                }
                // ?? #history-filter-start-date
                var summary = iframeDoc.getElementById('history-filter-start-date');
                if (summary) {
                    // ?? summary ??????????,??????
                    summary.style.backgroundColor = '#202320';
                    summary.style.color = '#a9a9a9';
                    summary.style.border = '0px solid #eaeef0';
                }
                // ?? #history-filter-start-time
                var summary = iframeDoc.getElementById('history-filter-start-time');
                if (summary) {
                    // ?? summary ??????????,??????
                    summary.style.backgroundColor = '#202320';
                    summary.style.color = '#a9a9a9';
                    summary.style.border = '0px solid #eaeef0';
                }
                // ?? #history-filter-end-date
                var summary = iframeDoc.getElementById('history-filter-end-date');
                if (summary) {
                    // ?? summary ??????????,??????
                    summary.style.backgroundColor = '#202320';
                    summary.style.color = '#a9a9a9';
                    summary.style.border = '0px solid #eaeef0';
                }
                // ?? #history-filter-end-time
                var summary = iframeDoc.getElementById('history-filter-end-time');
                if (summary) {
                    // ?? summary ??????????,??????
                    summary.style.backgroundColor = '#202320';
                    summary.style.color = '#a9a9a9';
                    summary.style.border = '0px solid #eaeef0';
                }
                // ?? #history-table
                var historyTable = iframeDoc.getElementById('history-table');
                if (historyTable) {
                    historyTable.style.border = '1px solid #3d3d3d';
                }


                var countersTable = iframeDoc.getElementById('counters-table');
                if (countersTable) {
                    countersTable.style.border = '1px solid #3d3d3d';
                }var provenanceTable = iframeDoc.getElementById('provenance-table');
                if (provenanceTable) {
                    provenanceTable.style.border = '1px solid #3d3d3d';
                }

                var controllerServicesTable = iframeDoc.getElementById('controller-services-table');
                if (controllerServicesTable) {
                    controllerServicesTable.style.border = '1px solid #3d3d3d';
                }var reportingTasksTable = iframeDoc.getElementById('reporting-tasks-table');
                if (reportingTasksTable) {
                    reportingTasksTable.style.border = '1px solid #3d3d3d';
                }var templatesTable = iframeDoc.getElementById('templates-table');
                if (templatesTable) {
                    templatesTable.style.border = '1px solid #3d3d3d';
                }var parameterProvidersTable = iframeDoc.getElementById('parameter-providers-table');
                if (parameterProvidersTable) {
                    parameterProvidersTable.style.border = '1px solid #3d3d3d';
                }

                // ??  summary-table ??
                var summaryTabs2 = iframeDoc.querySelector('.summary-table');
                if (summaryTabs2) {
                    // ?? summary-tabs ??????????,??????
                    summaryTabs2.style.backgroundColor = 'black';
                    summaryTabs2.style.color = '#a9a9a9';
                }
                // ??  .slick-pane ??
                var summaryTabs3 = iframeDoc.querySelector('.slick-pane');
                if (summaryTabs3) {
                    // ?? summary-tabs ??????????,??????
                    summaryTabs3.style.backgroundColor = 'black';
                    summaryTabs3.style.color = '#a9a9a9';
                }
                // ?????????
                // styleElem.sheet.deleteRule(0);
                //??css??????????????
                styleElem = iframeDoc.createElement('style');
                iframeDoc.head.appendChild(styleElem);
                // ??????????????
                styleElem.sheet.insertRule('.slick-cell, .slick-headerrow-column { background-color: black; color: #a9a9a9; }', 0);

                // ??????????????
                styleElem.sheet.insertRule('.slick-header-column.ui-state-default { background-color: #202320; color: #a9a9a9; }', 0);

                // ??????????????
                styleElem.sheet.insertRule('div.combo-button-normal { background-color: #202320 !important; color: #a9a9a9; }', 0);
                // ??????????????
                styleElem.sheet.insertRule('.tab { background-color: #202320; border: 1px solid #3d3d3d;}', 0);
                // ??????????????
                styleElem.sheet.insertRule('.tab, .tab button { color: #a9a9a9; }', 0);
                // ??????????????
                styleElem.sheet.insertRule('.slick-pane { background-color: black; color: #a9a9a9; }', 0);
                // ??????????????
                styleElem.sheet.insertRule('.combo { border: 1px solid #3d3d3d;}', 0);
                styleElem.sheet.insertRule('div.summary-table { border: 1px solid #3d3d3d;}', 0);
                styleElem.sheet.insertRule('.slick-cell, .slick-headerrow-column { border-left: 1px solid #3d3d3d; border-bottom: 1px solid #3d3d3d;}', 0);
                styleElem.sheet.insertRule('.combo-option-text .tab button { color: black; }', 0);
                styleElem.sheet.insertRule('.combo-option-text { color: white !important; }', 0);
                // ??????????????
                styleElem.sheet.insertRule('.combo-options ul > li { background-color: #202320; }', 0);
                var options = $(iframeDoc).find('.combo-options ul > li');
                if (options) {
                    options.hover(function () {
                        // ??????????
                        $(this).addClass('pointer').css('background', '#adadad');
                    }, function () {
                        // ??????????
                        $(this).removeClass('pointer').css('background', '#202320');
                    });
                }
                //Counters->Filter???
                styleElem.sheet.insertRule('input.filter { background-color: #202320; border: 0px solid #eaeef0;}', 0);
                // ??????????????Counters->Filter table?
                styleElem.sheet.insertRule('.slick-header-column.ui-state-default { background-color: #202320; color: #a9a9a9; }', 0);

                //Templates*
                // .dialog-header???? , .dialog, .dialog-header
                // .dialog??
                styleElem.sheet.insertRule('.dialog { background-color: black; }', 0);
                styleElem.sheet.insertRule('.dialog-header { background-color: black; color: #a9a9a9; }', 0);
                styleElem.sheet.insertRule('#reporting-tasks-table, #flow-analysis-rules-table, #registries-table, #parameter-contexts-table, #templates-table { border: 1px solid #3d3d3d; }', 0);
                styleElem.sheet.insertRule('#controller-services-table { border: 1px solid #3d3d3d; }', 0);
            }
        }

    }

};

// ???????????????
window.onbeforeunload = function() {
    console.log('?????????');
}
// ?????,?????????? myFunction ??
var timer = setInterval(myFunction, 1000*1); // ? 1000 ??,???????
// ???????????
function myFunction() {
    // console.log('?????');
    // ??????????????
    var aa = sessionStorage.getItem('theme');
    if (aa==='dark'){
        onPageLoaded(); // ????????????
        // console.log('???????');
    }else {
        // console.log('????');
    }
    document.title = 'Algopipe'
}
