/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
*/

/**
 * @module WVQRScan
 */

var argscheck = require('cordova/argscheck'),
    exec = require('cordova/exec');

var wvQRScanExport = {};

wvQRScanExport.setQrReader = function(successCallback, errorCallback, options) {
    argscheck.checkArgs('fFO', 'WVQRScan.setQrReader', arguments);
    options = options || {};
    var getValue = argscheck.getValue;

    var x = getValue(options.x, 0);
    var y = getValue(options.y, 0);
    var width = getValue(options.width, 100);
    var height = getValue(options.height, 100);

    var args = [x, y, width, height];

    exec(successCallback, errorCallback, "WVQRScan", "setQrReader", args);
};

wvQRScanExport.close = function(successCallback, errorCallback) {
    if (successCallback === undefined) {
        successCallback = function(){};
    }
    if (errorCallback === undefined) {
        successCallback = function(){};
    }

    exec(successCallback, errorCallback, "WVQRScan", "close", []);
};

module.exports = wvQRScanExport;
