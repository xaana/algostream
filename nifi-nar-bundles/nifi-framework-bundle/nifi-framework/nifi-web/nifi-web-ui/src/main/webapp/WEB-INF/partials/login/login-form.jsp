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
<div id="login-container" class="hidden">
    <div class="login-title">Log In
        <div id="login-user-links" class="links">
            <div id="user-logout-container" style="display: none;">
                <span id="user-logout" class="link" style="float: right">log out</span>
            </div>
            <div>
                <span id="user-home" class="link" style="float: right">home</span>
            </div>
        </div></div>
    <div class="setting">
        <div class="setting-field">
            <div class="setting-name">&nbsp;</div>
            <input type="text" placeholder="User" id="username" class="input-with-icon"/>
        </div>
    </div>
    <div class="setting">
        <div class="setting-field">
            <div class="setting-name">&nbsp;</div>
            <input type="password" placeholder="Password" id="password" class="input-with-icon2" autocomplete="off"/>
        </div>
    </div>
</div>
