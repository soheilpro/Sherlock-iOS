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
//  GTLSQLAdminSettings.m
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
//   GTLSQLAdminSettings (0 custom class methods, 12 custom properties)

#import "GTLSQLAdminSettings.h"

#import "GTLSQLAdminBackupConfiguration.h"
#import "GTLSQLAdminDatabaseFlags.h"
#import "GTLSQLAdminIpConfiguration.h"
#import "GTLSQLAdminLocationPreference.h"

// ----------------------------------------------------------------------------
//
//   GTLSQLAdminSettings
//

@implementation GTLSQLAdminSettings
@dynamic activationPolicy, authorizedGaeApplications, backupConfiguration,
         databaseFlags, databaseReplicationEnabled, ipConfiguration, kind,
         locationPreference, pricingPlan, replicationType, settingsVersion,
         tier;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObjectsAndKeys:
      [NSString class], @"authorizedGaeApplications",
      [GTLSQLAdminBackupConfiguration class], @"backupConfiguration",
      [GTLSQLAdminDatabaseFlags class], @"databaseFlags",
      nil];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"sql#settings"];
}

@end
