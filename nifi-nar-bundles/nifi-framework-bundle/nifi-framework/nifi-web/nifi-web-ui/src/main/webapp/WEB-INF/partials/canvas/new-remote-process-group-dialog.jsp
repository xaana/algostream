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
<div id="new-remote-process-group-dialog" class="hidden large-dialog">
    <img src="images/?70.png" style="width: 28px;height: 28px;margin: -1px 0px 0px -6px;cursor: pointer;position: absolute;right: 10px;top: 15px" onclick="$('#new-remote-process-group-dialog').hide()">
    <div class="dialog-content">
        <div class="setting">
            <div class="setting-name">
                <div class="fa fa-question-circle" alt="Info" title="Specify the remote target NiFi URLs. Multiple URLs can be specified in comma-separated format. Different protocols cannot be mixed. If remote NiFi is a cluster, two or more node URLs are recommended for better connection establishment availability."><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
             </div>
            <div class="setting-field">
                <input id="new-remote-process-group-uris" type="text" placeholder="URLs"/>
            </div>
        </div>
        <div class="setting">
            <div class="remote-process-group-setting-left">
                <div class="setting-name">
                    <div class="fa fa-question-circle" alt="Info" title="Specify the transport protocol to use for this Remote Process Group communication."><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                </div>
                <div class="setting-field">
                    <div id="new-remote-process-group-transport-protocol-combo"></div>
                </div>
            </div>
            <div class="remote-process-group-setting-right">
                <div class="setting-name">
                    <div class="fa fa-question-circle" alt="Info" title="The local network interface to send/receive data. If not specified, any local address is used. If clustered, all nodes must have an interface with this identifier."><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                </div>
                <div class="setting-field">
                    <input type="text" class="small-setting-input" id="new-remote-process-group-local-network-interface" placeholder="Local Network Interface"/>
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="setting">
            <div class="remote-process-group-setting-left">
                <div class="setting-name">
                    <div class="fa fa-question-circle" alt="Info" title="Specify the proxy server's hostname to use. If not specified, HTTP traffics are sent directly to the target NiFi instance."><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                </div>
                <div class="setting-field">
                    <input type="text" class="small-setting-input" id="new-remote-process-group-proxy-host" placeholder="HTTP Proxy server hostname"/>
                </div>
            </div>
            <div class="remote-process-group-setting-right">
                <div class="setting-name">
                    <div class="fa fa-question-circle" alt="Info" title="Specify the proxy server's port number, optional. If not specified, default port 80 will be used."><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                </div>
                <div class="setting-field">
                    <input type="text" class="small-setting-input" id="new-remote-process-group-proxy-port" placeholder="HTTP Proxy server port"/>
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="setting">
            <div class="remote-process-group-setting-left">
                <div class="setting-name">
                    <div class="fa fa-question-circle" alt="Info" title="Specify an user name to connect to the proxy server, optional."><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                </div>
                <div class="setting-field">
                    <input type="text" class="small-setting-input" id="new-remote-process-group-proxy-user" placeholder="HTTP Proxy user"/>
                </div>
            </div>
            <div class="remote-process-group-setting-right">
                <div class="setting-name">
                    <div class="fa fa-question-circle" alt="Info" title="Specify an user password to connect to the proxy server, optional."><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                </div>
                <div class="setting-field">
                    <input type="password" class="small-setting-input" id="new-remote-process-group-proxy-password" placeholder="HTTP Proxy password"/>
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="setting">
            <div class="remote-process-group-setting-left">
                <div class="setting-name">
                    <div class="fa fa-question-circle" alt="Info" title="When communication with this remote process group takes longer than this amount of time, it will timeout."><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                </div>
                <div class="setting-field">
                    <input type="text" class="small-setting-input" id="new-remote-process-group-timeout" placeholder="Communications timeout"/>
                </div>
            </div>
            <div class="remote-process-group-setting-right">
                <div class="setting-name">
                    <div class="fa fa-question-circle" alt="Info" title="When communication with this remote process group fails, it will not be scheduled again until this amount of time elapses."><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18"><defs><style>.a{}</style></defs><path class="a" d="M12.15,6.87c-.045.818-.292,1.455-1.545,2.7-.63.63-1.035,1.11-1.073,1.5a.63.63,0,0,1-.63.57h-.06a.63.63,0,0,1-.57-.69A4.065,4.065,0,0,1,9.75,8.685c1.133-1.133,1.155-1.5,1.17-1.875a1.627,1.627,0,0,0-.465-1.215A1.972,1.972,0,0,0,9,4.98,1.89,1.89,0,0,0,7.11,6.87a.634.634,0,1,1-1.267,0A3.158,3.158,0,0,1,9,3.75a3.248,3.248,0,0,1,2.355,1A2.872,2.872,0,0,1,12.15,6.87ZM8.887,14.25a.75.75,0,1,1,.75-.75.75.75,0,0,1-.75.75ZM9,0a9,9,0,1,0,9,9A9,9,0,0,0,9,0Z"/></svg></div>
                </div>
                <div class="setting-field">
                    <input type="text" class="small-setting-input" id="new-remote-process-group-yield-duration" placeholder="Yield duration"/>
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>