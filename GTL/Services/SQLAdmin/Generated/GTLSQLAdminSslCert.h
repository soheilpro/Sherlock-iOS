/* Copyright (c) 2014 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  GTLSQLAdminSslCert.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Cloud SQL Administration API (sqladmin/v1beta3)
// Description:
//   API for Cloud SQL database instance management.
// Documentation:
//   https://developers.google.com/cloud-sql/docs/admin-api/
// Classes:
//   GTLSQLAdminSslCert (0 custom class methods, 8 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLSQLAdminSslCert
//

// SslCerts Resource

@interface GTLSQLAdminSslCert : GTLObject

// PEM representation.
@property (copy) NSString *cert;

// Serial number, as extracted from the certificate.
@property (copy) NSString *certSerialNumber;

// User supplied name. Constrained to [a-zA-Z.-_ ]+.
@property (copy) NSString *commonName;

// Time when the certificate was created.
@property (retain) GTLDateTime *createTime;

// Time when the certificate expires.
@property (retain) GTLDateTime *expirationTime;

// Name of the database instance.
@property (copy) NSString *instance;

// This is always sql#sslCert.
@property (copy) NSString *kind;

// Sha1 Fingerprint.
@property (copy) NSString *sha1Fingerprint;

@end
