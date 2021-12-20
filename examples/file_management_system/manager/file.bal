// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/file;
import ballerina/io;

configurable string directoryPath = ?;

service /file on new http:Listener(9090) {
    resource function post create/[string fileName]() returns string|error {
        string filePath = check file:joinPath(directoryPath, fileName);
        check file:create(filePath);
        return "File is created successfully";
    }

    resource function delete delete/[string fileName]() returns string|error {
        string filePath = check file:joinPath(directoryPath, fileName);
        check file:remove(filePath);
        return "File is deleted successfully";
    }

    resource function put edit/[string fileName](@http:Payload string content) returns string|error {
        string filePath = check file:joinPath(directoryPath, fileName[0]);
        check io:fileWriteString(filePath, content);
        return "File is modified successfully";
    }
}
