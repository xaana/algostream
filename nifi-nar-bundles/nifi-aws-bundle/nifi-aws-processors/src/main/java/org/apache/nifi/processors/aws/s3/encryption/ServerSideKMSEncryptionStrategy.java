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
package org.apache.nifi.processors.aws.s3.encryption;

import com.amazonaws.services.s3.model.InitiateMultipartUploadRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.SSEAwsKeyManagementParams;

/**
 * This strategy uses a KMS key to perform server-side encryption.  Use this strategy when you want the server to perform the encryption,
 * (meaning you pay the cost of processing) and when you want to use a KMS key.
 *
 * See <a href="https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html">Using KMS Encryption</a>
 *
 */
public class ServerSideKMSEncryptionStrategy implements S3EncryptionStrategy {
    @Override
    public void configurePutObjectRequest(PutObjectRequest request, ObjectMetadata objectMetadata, String keyValue) {
        SSEAwsKeyManagementParams keyParams = new SSEAwsKeyManagementParams(keyValue);
        request.setSSEAwsKeyManagementParams(keyParams);
    }

    @Override
    public void configureInitiateMultipartUploadRequest(InitiateMultipartUploadRequest request, ObjectMetadata objectMetadata, String keyValue) {
        SSEAwsKeyManagementParams keyParams = new SSEAwsKeyManagementParams(keyValue);
        request.setSSEAwsKeyManagementParams(keyParams);
    }
}
