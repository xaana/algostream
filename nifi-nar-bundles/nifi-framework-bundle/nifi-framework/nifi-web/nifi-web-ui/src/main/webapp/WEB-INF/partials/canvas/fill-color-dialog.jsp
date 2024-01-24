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
<div id="fill-color-dialog" class="hidden">
    <img src="images/?70.png" style="width: 28px;height: 28px;margin: -1px 0px 0px -6px;cursor: pointer;position: absolute;right: 10px;top: 10px" onclick="$('#fill-color-dialog').hide()">
    <div class="dialog-content">
        <div class="setting" style="margin-bottom: 0px; display: block;">
            <div class="setting-name">Color</div>
            <div class="setting-field" style="margin-top: 14px">
                <input type="text" id="fill-color" value="#FFFFFF"/>
            </div>
            <%--            <div class="setting-name" style="margin-top: 10px;">Value</div>--%>
            <div class="setting-field" style="margin-top: 34px">
                <input type="text" id="fill-color-value" value="#FFFFFF" style="width: 100%"/>
            </div>
            <div class="setting-name" style="margin-top: 35px;">Preview</div>
            <div class="setting-field" style="margin-top: 14px">
                <div id="fill-color-processor-preview">
                    <div id="fill-color-processor-preview-icon" class="icon icon-processor" ></div>
                    <div id="fill-color-processor-preview-name" style="line-height: 25px; font-size: 12px; height: 25px; color: #ffffff; background-color: #5734D3; border-top-left-radius: 20px;border-top-right-radius: 20px;margin-left: 0">Processor Name</div>
                    <div style="width: 100%; height: 9px; border-bottom: 1px solid #ffffff; background-color: #ffffff;"></div>
                    <div style="width: 100%; height: 9px; border-bottom: 1px solid #ffffff; background-color: #ffffff;"></div>
                    <div style="width: 95%;height: 10px;border-bottom: 1px solid #ffffff;background-color: #ffffff;margin-left: 5px;"></div>
                    <div style="width: 80%; height: 9px; background-color: #ffffff; margin-left: 15px"></div>
                </div>
                <div id="fill-color-label-preview">
                    <div id="fill-color-label-preview-value">Label Value</div>
                </div>
            </div>
        </div>
    </div>
</div>