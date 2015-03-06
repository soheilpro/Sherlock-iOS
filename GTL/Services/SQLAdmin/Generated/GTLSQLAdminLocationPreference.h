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
//  GTLSQLAdminLocationPreference.h
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
//   GTLSQLAdminLocationPreference (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLSQLAdminLocationPreference
//

// Preferred location. This specifies where a Cloud SQL instance should
// preferably be located, either in a specific Compute Engine zone, or
// co-located with an App Engine application. Note that if the preferred
// location is not available, the instance will be located as close as possible
// within the region. Only one location may be specified.

@interface GTLSQLAdminLocationPreference : GTLObject

// The App Engine application to follow, it must be in the same region as the
// Cloud SQL instance.
@property (copy) NSString *followGaeApplication;

// This is always sql#locationPreference.
@property (copy) NSString *kind;

// The preferred Compute Engine zone (e.g. us-centra1-a, us-central1-b, etc.).
// Remapped to 'zoneProperty' to avoid NSObject's 'zone'.
@property (copy) NSString *zoneProperty;

@end
