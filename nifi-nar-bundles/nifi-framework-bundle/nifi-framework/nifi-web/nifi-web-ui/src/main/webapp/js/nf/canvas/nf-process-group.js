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

/* global d3, define, module, require, exports */

(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define(['jquery',
                'd3',
                'nf.Connection',
                'nf.Common',
                'nf.Client',
                'nf.CanvasUtils',
                'nf.Dialog',
                'nf.ng.D3Helpers'],
            function ($, d3, nfConnection, nfCommon, nfClient, nfCanvasUtils, nfDialog, d3Helpers) {
                return (nf.ProcessGroup = factory($, d3, nfConnection, nfCommon, nfClient, nfCanvasUtils, nfDialog, d3Helpers));
            });
    } else if (typeof exports === 'object' && typeof module === 'object') {
        module.exports = (nf.ProcessGroup =
            factory(require('jquery'),
                require('d3'),
                require('nf.Connection'),
                require('nf.Common'),
                require('nf.Client'),
                require('nf.CanvasUtils'),
                require('nf.Dialog'),
                require('nf.ng.D3Helpers')));
    } else {
        nf.ProcessGroup = factory(root.$,
            root.d3,
            root.nf.Connection,
            root.nf.Common,
            root.nf.Client,
            root.nf.CanvasUtils,
            root.nf.Dialog,
            root.nf.ng.D3Helpers);
    }
}(this, function ($, d3, nfConnection, nfCommon, nfClient, nfCanvasUtils, nfDialog, d3Helpers) {
    'use strict';

    var nfConnectable;
    var nfDraggable;
    var nfSelectable;
    var nfContextMenu;

    var PREVIEW_NAME_LENGTH = 30;

    var dimensions = {
        width: 384,
        height: 176
    };

    // ----------------------------
    // process groups currently on the graph
    // ----------------------------

    var processGroupMap;

    // -----------------------------------------------------------
    // cache for components that are added/removed from the canvas
    // -----------------------------------------------------------

    var removedCache;
    var addedCache;

    // --------------------
    // component containers
    // --------------------

    var processGroupContainer;

    // --------------------------
    // privately scoped functions
    // --------------------------

    /**
     * Determines whether the specified process group is under version control.
     *
     * @param d
     */
    var isUnderVersionControl = function (d) {
        return nfCommon.isDefinedAndNotNull(d.versionedFlowState);
    };

    /**
     * Selects the process group elements against the current process group map.
     */
    var select = function () {
        return processGroupContainer.selectAll('g.process-group').data(Array.from(processGroupMap.values()), function (d) {
            return d.id;
        });
    };

    /**
     * Renders the process groups in the specified selection.
     *
     * @param {selection} entered           The selection of process groups to be rendered
     * @param {boolean} selected            Whether the process group should be selected
     * @return the entered selection
     */
    var renderProcessGroups = function (entered, selected) {
        if (entered.empty()) {
            return entered;
        }

        var processGroup = d3Helpers.multiAttr(
            entered.append('g'),
            {
                'id': function (d) {
                    return 'id-' + d.id;
                },
                'class': 'process-group component'
            })
            .classed('selected', selected)
            .call(nfCanvasUtils.position);

        // ----
        // body
        // ----

        // process group border
        d3Helpers.multiAttr(
            processGroup.append('rect'),
            {
                'class': 'border',
                'width': function (d) {
                    return d.dimensions.width;
                },
                'height': function (d) {
                    return d.dimensions.height;
                },
                'fill': 'transparent',
                'stroke': 'transparent'
            });

        // process group body
        d3Helpers.multiAttr(
            processGroup.append('rect'),
            {
                'class': 'body',
                'width': function (d) {
                    return d.dimensions.width;
                },
                'height': function (d) {
                    return d.dimensions.height;
                },
                'filter': 'url(#component-drop-shadow)',
                'stroke-width': 0
            });

        // process group name background
        d3Helpers.multiAttr(
            processGroup.append('rect'),
            {
                'width': function (d) {
                    return d.dimensions.width;
                },
                'height': 32,
                'fill': '#b8c6cd'
            });

        // process group name
        d3Helpers.multiAttr(
            processGroup.append('text'),
            {
                'x': 10,
                'y': 20,
                'width': 300,
                'height': 16,
                'class': 'process-group-name'
            });

        // process group name
        d3Helpers.multiAttr(
            processGroup.append('text'),
            {
                'x': 10,
                'y': 21,
                'class': 'version-control'
            });

        // always support selecting and navigation
        processGroup.on('dblclick', function (event, d) {
            // enter this group on double click
            nfProcessGroup.enterGroup(d.id);
        })
            .call(nfSelectable.activate).call(nfContextMenu.activate);

        // only support dragging, connection, and drag and drop if appropriate
        processGroup.filter(function (d) {
            return d.permissions.canWrite && d.permissions.canRead;
        })
            .on('mouseover.drop', function (d) {
                // Using mouseover/out to workaround chrome issue #122746

                // get the target and ensure its not already been marked for drop
                var target = d3.select(this);
                if (!target.classed('drop')) {
                    var targetData = target.datum();

                    // see if there is a selection being dragged
                    var drag = d3.select('rect.drag-selection');
                    if (!drag.empty()) {
                        // filter the current selection by this group
                        var selection = nfCanvasUtils.getSelection().filter(function (d) {
                            return targetData.id === d.id;
                        });

                        // ensure this group isn't in the selection
                        if (selection.empty()) {
                            // mark that we are hovering over a drop area if appropriate
                            target.classed('drop', function () {
                                // get the current selection and ensure its disconnected
                                return nfConnection.isDisconnected(nfCanvasUtils.getSelection());
                            });
                        }
                    }
                }
            })
            .on('mouseout.drop', function (d) {
                // mark that we are no longer hovering over a drop area unconditionally
                d3.select(this).classed('drop', false);
            })
            .call(nfDraggable.activate)
            .call(nfConnectable.activate);

        return processGroup;
    };

    // attempt of space between component count and icon for process group contents
    var CONTENTS_SPACER = 10;
    var CONTENTS_VALUE_SPACER = 5;

    /**
     * Updates the process groups in the specified selection.
     *
     * @param {selection} updated               The process groups to be updated
     */
    var updateProcessGroups = function (updated) {
        if (updated.empty()) {
            return;
        }

        // process group border authorization
        updated.select('rect.border')
            .classed('unauthorized', function (d) {
                return d.permissions.canRead === false;
            });

        // process group body authorization
        updated.select('rect.body')
            .classed('unauthorized', function (d) {
                return d.permissions.canRead === false;
            });

        updated.each(function (processGroupData) {
            var processGroup = d3.select(this);
            var details = processGroup.select('g.process-group-details');

            // update the component behavior as appropriate
            nfCanvasUtils.editable(processGroup, nfConnectable, nfDraggable);

            // if this processor is visible, render everything
            if (processGroup.classed('visible')) {
                if (details.empty()) {
                    details = processGroup.append('g').attr('class', 'process-group-details');

                    // -------------------
                    // contents background
                    // -------------------

                    d3Helpers.multiAttr(
                        details.append('rect'),
                        {
                            'x': 0,
                            'y': 32,
                            'width': function () {
                                return processGroupData.dimensions.width;
                            },
                            'height': 24,
                            'fill': '#e3e8eb'
                        });

                    d3Helpers.multiAttr(
                        details.append('rect'),
                        {
                            'x': 0,
                            'y': function () {
                                return processGroupData.dimensions.height - 24;
                            },
                            'width': function () {
                                return processGroupData.dimensions.width;
                            },
                            'height': 24,
                            'fill': '#e3e8eb'
                        });

                    // --------
                    // contents
                    // --------

                    // transmitting icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'x': 10,
                            'y': 49,
                            'class': 'process-group-transmitting process-group-contents-icon',
                            'font-family': 'FontAwesome'
                        })
                        .text('\uf140')
                        .append('title')
                        .text('Transmitting Remote Process Groups');

                    // transmitting count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': 49,
                            'class': 'process-group-transmitting-count process-group-contents-count'
                        });

                    // not transmitting icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': 49,
                            'class': 'process-group-not-transmitting process-group-contents-icon',
                            'font-family': 'flowfont'
                        })
                        .text('\ue80a')
                        .append('title')
                        .text('Not Transmitting Remote Process Groups');

                    // not transmitting count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': 49,
                            'class': 'process-group-not-transmitting-count process-group-contents-count'
                        });

                    // running icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': 49,
                            'class': 'process-group-running process-group-contents-icon',
                            'font-family': 'FontAwesome'
                        })
                        .text('\uf04b')
                        .append('title')
                        .text('Running Components');

                    // running count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': 49,
                            'class': 'process-group-running-count process-group-contents-count'
                        });

                    // stopped icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': 49,
                            'class': 'process-group-stopped process-group-contents-icon',
                            'font-family': 'FontAwesome'
                        })
                        .text('\uf04d')
                        .append('title')
                        .text('Stopped Components');

                    // stopped count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': 49,
                            'class': 'process-group-stopped-count process-group-contents-count'
                        });

                    // invalid icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': 49,
                            'class': 'process-group-invalid process-group-contents-icon',
                            'font-family': 'FontAwesome'
                        })
                        .text('\uf071')
                        .append('title')
                        .text('Invalid Components');

                    // invalid count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': 49,
                            'class': 'process-group-invalid-count process-group-contents-count'
                        });

                    // disabled icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': 49,
                            'class': 'process-group-disabled process-group-contents-icon',
                            'font-family': 'flowfont'
                        })
                        .text('\ue802')
                        .append('title')
                        .text('Disabled Components');

                    // disabled count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': 49,
                            'class': 'process-group-disabled-count process-group-contents-count'
                        });

                    // up to date icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'x': 10,
                            'y': function () {
                                return processGroupData.dimensions.height - 7;
                            },
                            'class': 'process-group-up-to-date process-group-contents-icon',
                            'font-family': 'FontAwesome'
                        })
                        .text('\uf00c')
                        .append('title')
                        .text('Up to date Versioned Process Groups');

                    // up to date count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': function () {
                                return processGroupData.dimensions.height - 7;
                            },
                            'class': 'process-group-up-to-date-count process-group-contents-count'
                        });

                    // locally modified icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': function () {
                                return processGroupData.dimensions.height - 7;
                            },
                            'class': 'process-group-locally-modified process-group-contents-icon',
                            'font-family': 'FontAwesome'
                        })
                        .text('\uf069')
                        .append('title')
                        .text('Locally modified Versioned Process Groups');

                    // locally modified count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': function () {
                                return processGroupData.dimensions.height - 7;
                            },
                            'class': 'process-group-locally-modified-count process-group-contents-count'
                        });

                    // stale icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': function () {
                                return processGroupData.dimensions.height - 7;
                            },
                            'class': 'process-group-stale process-group-contents-icon',
                            'font-family': 'FontAwesome'
                        })
                        .text('\uf0aa')
                        .append('title')
                        .text('Stale Versioned Process Groups');

                    // stale count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': function () {
                                return processGroupData.dimensions.height - 7;
                            },
                            'class': 'process-group-stale-count process-group-contents-count'
                        });

                    // locally modified and stale icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': function () {
                                return processGroupData.dimensions.height - 7;
                            },
                            'class': 'process-group-locally-modified-and-stale process-group-contents-icon',
                            'font-family': 'FontAwesome'
                        })
                        .text('\uf06a')
                        .append('title')
                        .text('Locally modified and stale Versioned Process Groups');

                    // locally modified and stale count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': function () {
                                return processGroupData.dimensions.height - 7;
                            },
                            'class': 'process-group-locally-modified-and-stale-count process-group-contents-count'
                        });

                    // sync failure icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': function () {
                                return processGroupData.dimensions.height - 7;
                            },
                            'class': 'process-group-sync-failure process-group-contents-icon',
                            'font-family': 'FontAwesome'
                        })
                        .text('\uf128')
                        .append('title')
                        .text('Sync failure Versioned Process Groups');

                    // sync failure count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'y': function () {
                                return processGroupData.dimensions.height - 7;
                            },
                            'class': 'process-group-sync-failure-count process-group-contents-count'
                        });

                    // ----------------
                    // stats background
                    // ----------------

                    // queued
                    d3Helpers.multiAttr(
                        details.append('rect'),
                        {
                            'width': function () {
                                return processGroupData.dimensions.width;
                            },
                            'height': 19,
                            'x': 0,
                            'y': 66,
                            'fill': '#f4f6f7'
                        });

                    // border
                    d3Helpers.multiAttr(
                        details.append('rect'),
                        {
                            'width': function () {
                                return processGroupData.dimensions.width;
                            },
                            'height': 1,
                            'x': 0,
                            'y': 84,
                            'fill': '#c7d2d7'
                        });

                    // in
                    d3Helpers.multiAttr(
                        details.append('rect'),
                        {
                            'width': function () {
                                return processGroupData.dimensions.width;
                            },
                            'height': 19,
                            'x': 0,
                            'y': 85,
                            'fill': '#ffffff'
                        });

                    // border
                    d3Helpers.multiAttr(
                        details.append('rect'),
                        {
                            'width': function () {
                                return processGroupData.dimensions.width;
                            },
                            'height': 1,
                            'x': 0,
                            'y': 103,
                            'fill': '#c7d2d7'
                        });

                    // read/write
                    d3Helpers.multiAttr(
                        details.append('rect'),
                        {
                            'width': function () {
                                return processGroupData.dimensions.width;
                            },
                            'height': 19,
                            'x': 0,
                            'y': 104,
                            'fill': '#f4f6f7'
                        });

                    // border
                    d3Helpers.multiAttr(
                        details.append('rect'),
                        {
                            'width': function () {
                                return processGroupData.dimensions.width;
                            },
                            'height': 1,
                            'x': 0,
                            'y': 122,
                            'fill': '#c7d2d7'
                        });

                    // out
                    d3Helpers.multiAttr(
                        details.append('rect'),
                        {
                            'width': function () {
                                return processGroupData.dimensions.width;
                            },
                            'height': 19,
                            'x': 0,
                            'y': 123,
                            'fill': '#ffffff'
                        });

                    // -----
                    // stats
                    // -----

                    // stats label container
                    var processGroupStatsLabel = d3Helpers.multiAttr(
                        details.append('g'),
                        {
                            'transform': 'translate(6, 75)'
                        });

                    // queued label
                    d3Helpers.multiAttr(
                        processGroupStatsLabel.append('text'),
                        {
                            'width': 73,
                            'height': 10,
                            'x': 4,
                            'y': 5,
                            'class': 'stats-label'
                        })
                        .text('Queued');

                    // in label
                    d3Helpers.multiAttr(
                        processGroupStatsLabel.append('text'),
                        {
                            'width': 73,
                            'height': 10,
                            'x': 4,
                            'y': 24,
                            'class': 'stats-label'
                        })
                        .text('In');

                    // read/write label
                    d3Helpers.multiAttr(
                        processGroupStatsLabel.append('text'),
                        {
                            'width': 73,
                            'height': 10,
                            'x': 4,
                            'y': 42,
                            'class': 'stats-label'
                        })
                        .text('Read/Write');

                    // out label
                    d3Helpers.multiAttr(
                        processGroupStatsLabel.append('text'),
                        {
                            'width': 73,
                            'height': 10,
                            'x': 4,
                            'y': 60,
                            'class': 'stats-label'
                        })
                        .text('Out');

                    // stats value container
                    var processGroupStatsValue = d3Helpers.multiAttr(
                        details.append('g'),
                        {
                            'transform': 'translate(95, 75)'
                        });

                    // queued value
                    var queuedText = d3Helpers.multiAttr(
                        processGroupStatsValue.append('text'),
                        {
                            'width': 180,
                            'height': 10,
                            'x': 4,
                            'y': 5,
                            'class': 'process-group-queued stats-value'
                        });

                    // queued count
                    d3Helpers.multiAttr(
                        queuedText.append('tspan'),
                        {
                            'class': 'count'
                        });

                    // queued size
                    d3Helpers.multiAttr(
                        queuedText.append('tspan'),
                        {
                            'class': 'size'
                        });

                    // in value
                    var inText = d3Helpers.multiAttr(
                        processGroupStatsValue.append('text'),
                        {
                            'width': 180,
                            'height': 10,
                            'x': 4,
                            'y': 24,
                            'class': 'process-group-in stats-value'
                        });

                    // in count
                    d3Helpers.multiAttr(
                        inText.append('tspan'),
                        {
                            'class': 'count'
                        });

                    // in size
                    d3Helpers.multiAttr(
                        inText.append('tspan'),
                        {
                            'class': 'size'
                        });

                    // in
                    d3Helpers.multiAttr(
                        inText.append('tspan'),
                        {
                            'class': 'ports'
                        });

                    // in (remote)
                    d3Helpers.multiAttr(
                        inText.append('tspan'),
                        {
                            'class': 'public-ports'
                        });

                    // read/write value
                    d3Helpers.multiAttr(
                        processGroupStatsValue.append('text'),
                        {
                            'width': 180,
                            'height': 10,
                            'x': 4,
                            'y': 42,
                            'class': 'process-group-read-write stats-value'
                        });

                    // out value
                    var outText = d3Helpers.multiAttr(
                        processGroupStatsValue.append('text'),
                        {
                            'width': 180,
                            'height': 10,
                            'x': 4,
                            'y': 60,
                            'class': 'process-group-out stats-value'
                        });

                    // out ports
                    d3Helpers.multiAttr(
                        outText.append('tspan'),
                        {
                            'class': 'ports'
                        });

                    // out ports (remote)
                    d3Helpers.multiAttr(
                        outText.append('tspan'),
                        {
                            'class': 'public-ports'
                        });

                    // out count
                    d3Helpers.multiAttr(
                        outText.append('tspan'),
                        {
                            'class': 'count'
                        });

                    // out size
                    d3Helpers.multiAttr(
                        outText.append('tspan'),
                        {
                            'class': 'size'
                        });

                    // stats value container
                    var processGroupStatsInfo = d3Helpers.multiAttr(
                        details.append('g'),
                        {
                            'transform': 'translate(335, 75)'
                        });

                    // in info
                    d3Helpers.multiAttr(
                        processGroupStatsInfo.append('text'),
                        {
                            'width': 25,
                            'height': 10,
                            'x': 4,
                            'y': 24,
                            'class': 'stats-info'
                        })
                        .text('5 min');

                    // read/write info
                    d3Helpers.multiAttr(
                        processGroupStatsInfo.append('text'),
                        {
                            'width': 25,
                            'height': 10,
                            'x': 4,
                            'y': 42,
                            'class': 'stats-info'
                        })
                        .text('5 min');

                    // out info
                    d3Helpers.multiAttr(
                        processGroupStatsInfo.append('text'),
                        {
                            'width': 25,
                            'height': 10,
                            'x': 4,
                            'y': 60,
                            'class': 'stats-info'
                        })
                        .text('5 min');

                    // --------
                    // comments
                    // --------

                    d3Helpers.multiAttr(
                        details.append('path'),
                        {
                            'class': 'component-comments',
                            'transform': 'translate(' + (processGroupData.dimensions.width - 2) + ', ' + (processGroupData.dimensions.height - 10) + ')',
                            'd': 'm0,0 l0,8 l-8,0 z'
                        });

                    // -------------------
                    // active thread count
                    // -------------------

                    // active thread count
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'class': 'active-thread-count-icon',
                            'y': 20
                        })
                        .text('\ue83f');

                    // active thread icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'class': 'active-thread-count',
                            'y': 20
                        });

                    // ---------
                    // bulletins
                    // ---------

                    // bulletin background
                    d3Helpers.multiAttr(
                        details.append('rect'),
                        {
                            'class': 'bulletin-background',
                            'x': function () {
                                return processGroupData.dimensions.width - 24;
                            },
                            'y': 32,
                            'width': 24,
                            'height': 24
                        });

                    // bulletin icon
                    d3Helpers.multiAttr(
                        details.append('text'),
                        {
                            'class': 'bulletin-icon',
                            'x': function () {
                                return processGroupData.dimensions.width - 17;
                            },
                            'y': 49
                        })
                        .text('\uf24a');
                }

                // update transmitting
                var transmitting = details.select('text.process-group-transmitting')
                    .classed('transmitting', function (d) {
                        return d.permissions.canRead && d.activeRemotePortCount > 0;
                    })
                    .classed('zero', function (d) {
                        return d.permissions.canRead && d.activeRemotePortCount === 0;
                    });
                var transmittingCount = details.select('text.process-group-transmitting-count')
                    .attr('x', function () {
                        var transmittingCountX = parseInt(transmitting.attr('x'), 10);
                        return transmittingCountX + Math.round(transmitting.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                    })
                    .text(function (d) {
                        return d.activeRemotePortCount;
                    });
                transmittingCount.append('title').text('Transmitting Remote Process Groups');

                // update not transmitting
                var notTransmitting = details.select('text.process-group-not-transmitting')
                    .classed('not-transmitting', function (d) {
                        return d.permissions.canRead && d.inactiveRemotePortCount > 0;
                    })
                    .classed('zero', function (d) {
                        return d.permissions.canRead && d.inactiveRemotePortCount === 0;
                    })
                    .attr('x', function () {
                        var transmittingX = parseInt(transmittingCount.attr('x'), 10);
                        return transmittingX + Math.round(transmittingCount.node().getComputedTextLength()) + CONTENTS_SPACER;
                    });
                var notTransmittingCount = details.select('text.process-group-not-transmitting-count')
                    .attr('x', function () {
                        var notTransmittingCountX = parseInt(notTransmitting.attr('x'), 10);
                        return notTransmittingCountX + Math.round(notTransmitting.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                    })
                    .text(function (d) {
                        return d.inactiveRemotePortCount;
                    });
                notTransmittingCount.append('title').text('Not transmitting Remote Process Groups');

                // update running
                var running = details.select('text.process-group-running')
                    .classed('running', function (d) {
                        return d.permissions.canRead && d.component.runningCount > 0;
                    })
                    .classed('zero', function (d) {
                        return d.permissions.canRead && d.component.runningCount === 0;
                    })
                    .attr('x', function () {
                        var notTransmittingX = parseInt(notTransmittingCount.attr('x'), 10);
                        return notTransmittingX + Math.round(notTransmittingCount.node().getComputedTextLength()) + CONTENTS_SPACER;
                    });
                var runningCount = details.select('text.process-group-running-count')
                    .attr('x', function () {
                        var runningCountX = parseInt(running.attr('x'), 10);
                        return runningCountX + Math.round(running.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                    })
                    .text(function (d) {
                        return d.runningCount;
                    });
                runningCount.append('title').text('Running Components');

                // update stopped
                var stopped = details.select('text.process-group-stopped')
                    .classed('stopped', function (d) {
                        return d.permissions.canRead && d.component.stoppedCount > 0;
                    })
                    .classed('zero', function (d) {
                        return d.permissions.canRead && d.component.stoppedCount === 0;
                    })
                    .attr('x', function () {
                        var runningX = parseInt(runningCount.attr('x'), 10);
                        return runningX + Math.round(runningCount.node().getComputedTextLength()) + CONTENTS_SPACER;
                    });
                var stoppedCount = details.select('text.process-group-stopped-count')
                    .attr('x', function () {
                        var stoppedCountX = parseInt(stopped.attr('x'), 10);
                        return stoppedCountX + Math.round(stopped.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                    })
                    .text(function (d) {
                        return d.stoppedCount;
                    });
                stoppedCount.append('title').text('Stopped Components');

                // update invalid
                var invalid = details.select('text.process-group-invalid')
                    .classed('invalid', function (d) {
                        return d.permissions.canRead && d.component.invalidCount > 0;
                    })
                    .classed('zero', function (d) {
                        return d.permissions.canRead && d.component.invalidCount === 0;
                    })
                    .attr('x', function () {
                        var stoppedX = parseInt(stoppedCount.attr('x'), 10);
                        return stoppedX + Math.round(stoppedCount.node().getComputedTextLength()) + CONTENTS_SPACER;
                    });
                var invalidCount = details.select('text.process-group-invalid-count')
                    .attr('x', function () {
                        var invalidCountX = parseInt(invalid.attr('x'), 10);
                        return invalidCountX + Math.round(invalid.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                    })
                    .text(function (d) {
                        return d.invalidCount;
                    });
                invalidCount.append('title').text('Invalid Components');

                // update disabled
                var disabled = details.select('text.process-group-disabled')
                    .classed('disabled', function (d) {
                        return d.permissions.canRead && d.component.disabledCount > 0;
                    })
                    .classed('zero', function (d) {
                        return d.permissions.canRead && d.component.disabledCount === 0;
                    })
                    .attr('x', function () {
                        var invalidX = parseInt(invalidCount.attr('x'), 10);
                        return invalidX + Math.round(invalidCount.node().getComputedTextLength()) + CONTENTS_SPACER;
                    });
                var disabledCount = details.select('text.process-group-disabled-count')
                    .attr('x', function () {
                        var disabledCountX = parseInt(disabled.attr('x'), 10);
                        return disabledCountX + Math.round(disabled.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                    })
                    .text(function (d) {
                        return d.disabledCount;
                    });
                disabledCount.append('title').text('Disabled Components');

                // up to date current
                var upToDate = details.select('text.process-group-up-to-date')
                    .classed('up-to-date', function (d) {
                        return d.permissions.canRead && d.component.upToDateCount > 0;
                    })
                    .classed('zero', function (d) {
                        return d.permissions.canRead && d.component.upToDateCount === 0;
                    });
                var upToDateCount = details.select('text.process-group-up-to-date-count')
                    .attr('x', function () {
                        var updateToDateCountX = parseInt(upToDate.attr('x'), 10);
                        return updateToDateCountX + Math.round(upToDate.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                    })
                    .text(function (d) {
                        return d.upToDateCount;
                    });
                upToDateCount.append('title').text('Up to date Versioned Process Groups');

                // update locally modified
                var locallyModified = details.select('text.process-group-locally-modified')
                    .classed('locally-modified', function (d) {
                        return d.permissions.canRead && d.component.locallyModifiedCount > 0;
                    })
                    .classed('zero', function (d) {
                        return d.permissions.canRead && d.component.locallyModifiedCount === 0;
                    })
                    .attr('x', function () {
                        var upToDateX = parseInt(upToDateCount.attr('x'), 10);
                        return upToDateX + Math.round(upToDateCount.node().getComputedTextLength()) + CONTENTS_SPACER;
                    });
                var locallyModifiedCount = details.select('text.process-group-locally-modified-count')
                    .attr('x', function () {
                        var locallyModifiedCountX = parseInt(locallyModified.attr('x'), 10);
                        return locallyModifiedCountX + Math.round(locallyModified.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                    })
                    .text(function (d) {
                        return d.locallyModifiedCount;
                    });
                locallyModifiedCount.append('title').text('Locally modified Versioned Process Groups');

                // update stale
                var stale = details.select('text.process-group-stale')
                    .classed('stale', function (d) {
                        return d.permissions.canRead && d.component.staleCount > 0;
                    })
                    .classed('zero', function (d) {
                        return d.permissions.canRead && d.component.staleCount === 0;
                    })
                    .attr('x', function () {
                        var locallyModifiedX = parseInt(locallyModifiedCount.attr('x'), 10);
                        return locallyModifiedX + Math.round(locallyModifiedCount.node().getComputedTextLength()) + CONTENTS_SPACER;
                    });
                var staleCount = details.select('text.process-group-stale-count')
                    .attr('x', function () {
                        var staleCountX = parseInt(stale.attr('x'), 10);
                        return staleCountX + Math.round(stale.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                    })
                    .text(function (d) {
                        return d.staleCount;
                    });
                staleCount.append('title').text('Stale Versioned Process Groups');

                // update locally modified and stale
                var locallyModifiedAndStale = details.select('text.process-group-locally-modified-and-stale')
                    .classed('locally-modified-and-stale', function (d) {
                        return d.permissions.canRead && d.component.locallyModifiedAndStaleCount > 0;
                    })
                    .classed('zero', function (d) {
                        return d.permissions.canRead && d.component.locallyModifiedAndStaleCount === 0;
                    })
                    .attr('x', function () {
                        var staleX = parseInt(staleCount.attr('x'), 10);
                        return staleX + Math.round(staleCount.node().getComputedTextLength()) + CONTENTS_SPACER;
                    });
                var locallyModifiedAndStaleCount = details.select('text.process-group-locally-modified-and-stale-count')
                    .attr('x', function () {
                        var locallyModifiedAndStaleCountX = parseInt(locallyModifiedAndStale.attr('x'), 10);
                        return locallyModifiedAndStaleCountX + Math.round(locallyModifiedAndStale.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                    })
                    .text(function (d) {
                        return d.locallyModifiedAndStaleCount;
                    });
                locallyModifiedAndStaleCount.append('title').text('Locally modified and stale Versioned Process Groups');

                // update sync failure
                var syncFailure = details.select('text.process-group-sync-failure')
                    .classed('sync-failure', function (d) {
                        return d.permissions.canRead && d.component.syncFailureCount > 0;
                    })
                    .classed('zero', function (d) {
                        return d.permissions.canRead && d.component.syncFailureCount === 0;
                    })
                    .attr('x', function () {
                        var syncFailureX = parseInt(locallyModifiedAndStaleCount.attr('x'), 10);
                        return syncFailureX + Math.round(locallyModifiedAndStaleCount.node().getComputedTextLength()) + CONTENTS_SPACER - 2;
                    });
                var syncFailureCount = details.select('text.process-group-sync-failure-count')
                    .attr('x', function () {
                        var syncFailureCountX = parseInt(syncFailure.attr('x'), 10);
                        return syncFailureCountX + Math.round(syncFailure.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                    })
                    .text(function (d) {
                        return d.syncFailureCount;
                    });
                syncFailureCount.append('title').text('Sync failure Versioned Process Groups');

                // update version control information
                var versionControl = processGroup.select('text.version-control')
                    .style('visibility', isUnderVersionControl(processGroupData) ? 'visible' : 'hidden')
                    .style('fill', function () {
                        if (isUnderVersionControl(processGroupData)) {
                            var vciState = processGroupData.versionedFlowState;
                            if (vciState === 'SYNC_FAILURE') {
                                return '#666666';
                            } else if (vciState === 'LOCALLY_MODIFIED_AND_STALE') {
                                return '#BA554A';
                            } else if (vciState === 'STALE') {
                                return '#BA554A';
                            } else if (vciState === 'LOCALLY_MODIFIED') {
                                return '#666666';
                            } else {
                                return '#1A9964';
                            }
                        } else {
                            return '#000';
                        }
                    })
                    .text(function () {
                        if (isUnderVersionControl(processGroupData)) {
                            var vciState = processGroupData.versionedFlowState;
                            if (vciState === 'SYNC_FAILURE') {
                                return '\uf128';
                            } else if (vciState === 'LOCALLY_MODIFIED_AND_STALE') {
                                return '\uf06a';
                            } else if (vciState === 'STALE') {
                                return '\uf0aa';
                            } else if (vciState === 'LOCALLY_MODIFIED') {
                                return '\uf069';
                            } else {
                                return '\uf00c';
                            }
                        } else {
                            return '';
                        }
                    });

                if (processGroupData.permissions.canRead) {
                    // version control tooltip
                    versionControl.each(function () {
                        // get the tip
                        var tip = d3.select('#version-control-tip-' + processGroupData.id);

                        // if there are validation errors generate a tooltip
                        if (isUnderVersionControl(processGroupData)) {
                            // create the tip if necessary
                            if (tip.empty()) {
                                tip = d3.select('#process-group-tooltips').append('div')
                                    .attr('id', function () {
                                        return 'version-control-tip-' + processGroupData.id;
                                    })
                                    .attr('class', 'tooltip nifi-tooltip');
                            }

                            // update the tip
                            tip.html(function () {
                                var vci = processGroupData.component.versionControlInformation;
                                var versionControlTip = $('<div></div>').text('Tracking to "' + vci.flowName + '" Version ' + vci.version + ' in "' + vci.registryName + ' - ' + vci.bucketName + '"');
                                var versionControlStateTip = $('<div></div>').text(nfCommon.getVersionControlTooltip(vci));
                                return $('<div></div>').append(versionControlTip).append('<br/>').append(versionControlStateTip).html();
                            });

                            // add the tooltip
                            nfCanvasUtils.canvasTooltip(tip, d3.select(this));
                        } else {
                            // remove the tip if necessary
                            if (!tip.empty()) {
                                tip.remove();
                            }
                        }
                    });

                    // update the process group comments
                    processGroup.select('path.component-comments')
                        .style('visibility', nfCommon.isBlank(processGroupData.component.comments) ? 'hidden' : 'visible')
                        .each(function () {
                            // get the tip
                            var tip = d3.select('#comments-tip-' + processGroupData.id);

                            // if there are validation errors generate a tooltip
                            if (nfCommon.isBlank(processGroupData.component.comments)) {
                                // remove the tip if necessary
                                if (!tip.empty()) {
                                    tip.remove();
                                }
                            } else {
                                // create the tip if necessary
                                if (tip.empty()) {
                                    tip = d3.select('#process-group-tooltips').append('div')
                                        .attr('id', function () {
                                            return 'comments-tip-' + processGroupData.id;
                                        })
                                        .attr('class', 'tooltip nifi-tooltip');
                                }

                                // update the tip
                                tip.text(processGroupData.component.comments);

                                // add the tooltip
                                nfCanvasUtils.canvasTooltip(tip, d3.select(this));
                            }
                        });

                    // update the process group name
                    d3Helpers.multiAttr(
                        processGroup.select('text.process-group-name'),
                        {
                            'x': function () {
                                if (isUnderVersionControl(processGroupData)) {
                                    var versionControlX = parseInt(versionControl.attr('x'), 10);
                                    return versionControlX + Math.round(versionControl.node().getComputedTextLength()) + CONTENTS_VALUE_SPACER;
                                } else {
                                    return 10;
                                }
                            },
                            'width': function () {
                                if (isUnderVersionControl(processGroupData)) {
                                    var versionControlX = parseInt(versionControl.attr('x'), 10);
                                    var processGroupNameX = parseInt(d3.select(this).attr('x'), 10);
                                    return 300 - (processGroupNameX - versionControlX);
                                } else {
                                    return 300;
                                }
                            }
                        })
                        .each(function (d) {
                            var processGroupName = d3.select(this);

                            // reset the process group name to handle any previous state
                            processGroupName.text(null).selectAll('title').remove();

                            // apply ellipsis to the process group name as necessary
                            nfCanvasUtils.ellipsis(processGroupName, d.component.name, 'group-name');
                        })
                        .append('title')
                        .text(function (d) {
                            return d.component.name;
                        });
                } else {
                    // clear the process group comments
                    processGroup.select('path.component-comments').style('visibility', 'hidden');

                    // clear the process group name
                    d3Helpers.multiAttr(
                        processGroup.select('text.process-group-name'),
                        {
                            'x': 10,
                            'width': 316
                        })
                        .text(null);

                    // clear tooltips
                    processGroup.call(removeTooltips);
                }

                // populate the stats
                processGroup.call(updateProcessGroupStatus);
            } else {
                if (processGroupData.permissions.canRead) {
                    // update the process group name
                    processGroup.select('text.process-group-name')
                        .text(function (d) {
                            var name = d.component.name;
                            if (name.length > PREVIEW_NAME_LENGTH) {
                                return name.substring(0, PREVIEW_NAME_LENGTH) + String.fromCharCode(8230);
                            } else {
                                return name;
                            }
                        });
                } else {
                    // clear the process group name
                    processGroup.select('text.process-group-name').text(null);
                }

                // remove the tooltips
                processGroup.call(removeTooltips);

                // remove the details if necessary
                if (!details.empty()) {
                    details.remove();
                }
            }
        });
    };

    /**
     * Updates the process group status.
     *
     * @param {selection} updated           The process groups to be updated
     */
    var updateProcessGroupStatus = function (updated) {
        if (updated.empty()) {
            return;
        }

        // queued count value
        updated.select('text.process-group-queued tspan.count')
            .text(function (d) {
                return nfCommon.substringBeforeFirst(d.status.aggregateSnapshot.queued, ' ');
            });

        // queued size value
        updated.select('text.process-group-queued tspan.size')
            .text(function (d) {
                return ' ' + nfCommon.substringAfterFirst(d.status.aggregateSnapshot.queued, ' ');
            });

        // in count value
        updated.select('text.process-group-in tspan.count')
            .text(function (d) {
                return nfCommon.substringBeforeFirst(d.status.aggregateSnapshot.input, ' ');
            });

        // in size value
        updated.select('text.process-group-in tspan.size')
            .text(function (d) {
                return ' ' + nfCommon.substringAfterFirst(d.status.aggregateSnapshot.input, ' ');
            });

        // in ports value
        updated.select('text.process-group-in tspan.ports')
            .text(function (d) {
                return ' ' + String.fromCharCode(8594) + ' ' + d.inputPortCount;
            });

        // in ports value (remote)
        updated.select('text.process-group-in tspan.public-ports')
            .text(function (d) {
                return d.publicInputPortCount > 0 ? ' (' + d.publicInputPortCount + ' remote)' : '';
            });

        // read/write value
        updated.select('text.process-group-read-write')
            .text(function (d) {
                return d.status.aggregateSnapshot.read + ' / ' + d.status.aggregateSnapshot.written;
            });

        // out ports value
        updated.select('text.process-group-out tspan.ports')
            .text(function (d) {
                return d.outputPortCount;
            });

        // out ports value (remote)
        updated.select('text.process-group-out tspan.public-ports')
            .text(function (d) {
                return d.publicOutputPortCount > 0 ? ' (' + d.publicOutputPortCount + ' remote) ' : '';
            });

        // out count value
        updated.select('text.process-group-out tspan.count')
            .text(function (d) {
                return ' ' + String.fromCharCode(8594) + ' ' + nfCommon.substringBeforeFirst(d.status.aggregateSnapshot.output, ' ');
            });

        // out size value
        updated.select('text.process-group-out tspan.size')
            .text(function (d) {
                return ' ' + nfCommon.substringAfterFirst(d.status.aggregateSnapshot.output, ' ');
            });

        updated.each(function (d) {
            var processGroup = d3.select(this);
            var offset = 0;

            // -------------------
            // active thread count
            // -------------------

            nfCanvasUtils.activeThreadCount(processGroup, d, function (off) {
                offset = off;
            });

            // ---------
            // bulletins
            // ---------

            processGroup.select('rect.bulletin-background').classed('has-bulletins', function () {
                return !nfCommon.isEmpty(d.status.aggregateSnapshot.bulletins);
            });

            nfCanvasUtils.bulletins(processGroup, d, function () {
                return d3.select('#process-group-tooltips');
            }, offset);
        });
    };

    /**
     * Removes the process groups in the specified selection.
     *
     * @param {selection} removed               The process groups to be removed
     */
    var removeProcessGroups = function (removed) {
        if (removed.empty()) {
            return;
        }

        removed.call(removeTooltips).remove();
    };

    /**
     * Removes the tooltips for the process groups in the specified selection.
     *
     * @param {selection} removed
     */
    var removeTooltips = function (removed) {
        removed.each(function (d) {
            // remove any associated tooltips
            $('#bulletin-tip-' + d.id).remove();
            $('#version-control-tip-' + d.id).remove();
            $('#comments-tip-' + d.id).remove();
        });
    };

    var nfProcessGroup = {
        /**
         * Initializes of the Process Group handler.
         *
         * @param nfConnectableRef   The nfConnectable module.
         * @param nfDraggableRef   The nfDraggable module.
         * @param nfSelectableRef   The nfSelectable module.
         * @param nfContextMenuRef   The nfContextMenu module.
         */
        init: function (nfConnectableRef, nfDraggableRef, nfSelectableRef, nfContextMenuRef) {
            nfConnectable = nfConnectableRef;
            nfDraggable = nfDraggableRef;
            nfSelectable = nfSelectableRef;
            nfContextMenu = nfContextMenuRef;

            processGroupMap = new Map();
            removedCache = new Map();
            addedCache = new Map();

            // create the process group container
            processGroupContainer = d3Helpers.multiAttr(
                d3.select('#canvas').append('g'),
                {
                    'pointer-events': 'all',
                    'class': 'process-groups'
                });
        },

        /**
         * Adds the specified process group entity.
         *
         * @param processGroupEntities       The process group
         * @param options           Configuration options
         */
        add: function (processGroupEntities, options) {
            var selectAll = false;
            if (nfCommon.isDefinedAndNotNull(options)) {
                selectAll = nfCommon.isDefinedAndNotNull(options.selectAll) ? options.selectAll : selectAll;
            }

            // get the current time
            var now = new Date().getTime();

            var add = function (processGroupEntity) {
                addedCache.set(processGroupEntity.id, now);

                // add the process group
                processGroupMap.set(processGroupEntity.id, $.extend({
                    type: 'ProcessGroup',
                    dimensions: dimensions
                }, processGroupEntity));
            };

            // determine how to handle the specified process groups
            if ($.isArray(processGroupEntities)) {
                $.each(processGroupEntities, function (_, processGroupEntity) {
                    add(processGroupEntity);
                });
            } else if (nfCommon.isDefinedAndNotNull(processGroupEntities)) {
                add(processGroupEntities);
            }

            // select
            var selection = select();

            // enter
            var entered = renderProcessGroups(selection.enter(), selectAll);

            // update
            updateProcessGroups(selection.merge(entered));
        },

        /**
         * Populates the graph with the specified process groups.
         *
         * @argument {object | array} processGroupEntities                    The process groups to add
         * @argument {object} options                Configuration options
         */
        set: function (processGroupEntities, options) {
            var selectAll = false;
            var transition = false;
            var overrideRevisionCheck = false;
            if (nfCommon.isDefinedAndNotNull(options)) {
                selectAll = nfCommon.isDefinedAndNotNull(options.selectAll) ? options.selectAll : selectAll;
                transition = nfCommon.isDefinedAndNotNull(options.transition) ? options.transition : transition;
                overrideRevisionCheck = nfCommon.isDefinedAndNotNull(options.overrideRevisionCheck) ? options.overrideRevisionCheck : overrideRevisionCheck;
            }

            var set = function (proposedProcessGroupEntity) {
                var currentProcessGroupEntity = processGroupMap.get(proposedProcessGroupEntity.id);

                // set the process group if appropriate due to revision and wasn't previously removed
                if ((nfClient.isNewerRevision(currentProcessGroupEntity, proposedProcessGroupEntity) && !removedCache.has(proposedProcessGroupEntity.id)) || overrideRevisionCheck === true) {
                    processGroupMap.set(proposedProcessGroupEntity.id, $.extend({
                        type: 'ProcessGroup',
                        dimensions: dimensions
                    }, proposedProcessGroupEntity));
                }
            };

            // determine how to handle the specified process groups
            if ($.isArray(processGroupEntities)) {
                $.each(Array.from(processGroupMap.keys()), function (_, key) {
                    var currentProcessGroupEntity = processGroupMap.get(key);
                    var isPresent = $.grep(processGroupEntities, function (proposedProcessGroupEntity) {
                        return proposedProcessGroupEntity.id === currentProcessGroupEntity.id;
                    });

                    // if the current process group is not present and was not recently added, remove it
                    if (isPresent.length === 0 && !addedCache.has(key)) {
                        processGroupMap['delete'](key);
                    }
                });
                $.each(processGroupEntities, function (_, processGroupEntity) {
                    set(processGroupEntity);
                });
            } else if (nfCommon.isDefinedAndNotNull(processGroupEntities)) {
                set(processGroupEntities);
            }

            // select
            var selection = select();

            // enter
            var entered = renderProcessGroups(selection.enter(), selectAll);

            // update
            var updated = selection.merge(entered);
            updated.call(updateProcessGroups).call(nfCanvasUtils.position, transition);

            // exit
            selection.exit().call(removeProcessGroups);
        },

        /**
         * If the process group id is specified it is returned. If no process group id
         * specified, all process groups are returned.
         *
         * @param {string} id
         */
        get: function (id) {
            if (nfCommon.isUndefined(id)) {
                return Array.from(processGroupMap.values());
            } else {
                return processGroupMap.get(id);
            }
        },

        /**
         * If the process group id is specified it is refresh according to the current
         * state. If no process group id is specified, all process groups are refreshed.
         *
         * @param {string} id      Optional
         */
        refresh: function (id) {
            if (nfCommon.isDefinedAndNotNull(id)) {
                d3.select('#id-' + id).call(updateProcessGroups);
            } else {
                d3.selectAll('g.process-group').call(updateProcessGroups);
            }
        },

        /**
         * Refreshes the components necessary after a pan event.
         */
        pan: function () {
            d3.selectAll('g.process-group.entering, g.process-group.leaving').call(updateProcessGroups);
        },

        /**
         * Reloads the process group state from the server and refreshes the UI.
         * If the process group is currently unknown, this function reloads the canvas.
         *
         * @param {string} id The process group id
         */
        reload: function (id) {
            if (processGroupMap.has(id)) {
                var processGroupEntity = processGroupMap.get(id);
                return $.ajax({
                    type: 'GET',
                    url: processGroupEntity.uri,
                    dataType: 'json'
                }).done(function (response) {
                    nfProcessGroup.set(response);
                });
            }
        },

        /**
         * Positions the component.
         *
         * @param {string} id   The id
         */
        position: function (id) {
            d3.select('#id-' + id).call(nfCanvasUtils.position);
        },

        /**
         * Removes the specified process group.
         *
         * @param {string} processGroupIds      The process group id(s)
         */
        remove: function (processGroupIds) {
            var now = new Date().getTime();

            if ($.isArray(processGroupIds)) {
                $.each(processGroupIds, function (_, processGroupId) {
                    removedCache.set(processGroupId, now);
                    processGroupMap['delete'](processGroupId);
                });
            } else {
                removedCache.set(processGroupIds, now);
                processGroupMap['delete'](processGroupIds);
            }

            // apply the selection and handle all removed process groups
            select().exit().call(removeProcessGroups);
        },

        /**
         * Removes all process groups.
         */
        removeAll: function () {
            nfProcessGroup.remove(Array.from(processGroupMap.keys()));
        },

        /**
         * Expires the caches up to the specified timestamp.
         *
         * @param timestamp
         */
        expireCaches: function (timestamp) {
            var expire = function (cache) {
                cache.forEach(function (entryTimestamp, id) {
                    if (timestamp > entryTimestamp) {
                        cache['delete'](id);
                    }
                });
            };

            expire(addedCache);
            expire(removedCache);
        },

        /**
         * Enters the specified group.
         *
         * @param {string} groupId
         */
        enterGroup: function (groupId) {

            // hide the context menu
            nfContextMenu.hide();

            // reload the graph
            return nfCanvasUtils.reload(groupId).done(function () {

                // attempt to restore the view
                var viewRestored = nfCanvasUtils.restoreUserView();

                // if the view was not restore attempt to fit
                if (viewRestored === false) {
                    nfCanvasUtils.fitCanvas();
                }

                // update URL deep linking params
                nfCanvasUtils.setURLParameters(groupId, d3.select());

            }).fail(function () {
                nfDialog.showOkDialog({
                    headerText: 'Process Group',
                    dialogContent: 'Unable to enter the selected group.'
                });
            });
        }
    };

    return nfProcessGroup;
}));