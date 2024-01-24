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
<div id="new-process-group-dialog" class="hidden medium-short-dialog">
    <img id="cancel_dialog_view" src="images/?70.png">
    <div class="dialog-content">
        <div class="setting">
<%--            <div class="setting-name">Process group name</div>--%>
            <div class="setting-field" style="margin-top: 0px">

                <div id="select-file-button" >
                    <input id="new-process-group-name" type="text" placeholder="Process group name"  />

                    <button class="icon icon-template-import" id="upload-file-field-button" title="Browse">
                        <img src="images/???51.png" style="width: 18px">
                    </button>
                    <form id="file-upload-form" enctype="multipart/form-data" method="post">
                        <input type="file" name="file" id="upload-file-field"/>
                    </form>
                </div>
            </div>
        </div>
        <div class="setting">
<%--                <div class="setting-name">Parameter Context</div>--%>
                <div class="setting-field">
                    <div id="new-pg-parameter-context-combo" style="color: #666;background-color: #f3f3f3 ;font-size: 16px ; width: 100%" ></div>
                    <div id="parameters-from-uploaded-flow">Parameters will be imported from the uploaded Flow Definition.</div>
                </div>
        </div>
        <div id="file-cancel-button-container">
            <button class="icon" id="file-cancel-button" aria-hidden="true" title="Cancel the selected file">
                <i class="fa fa-times"></i>
            </button>
        </div>
        <div class="setting">
            <div id="submit-file-container">
                <div class="setting-name">
                    <span id="file-to-upload" title="File to upload">
                        File to Upload:
                    </span>
                </div>
                <div id="selected-file-name"></div>
            </div>
        </div>
    </div>
</div>
