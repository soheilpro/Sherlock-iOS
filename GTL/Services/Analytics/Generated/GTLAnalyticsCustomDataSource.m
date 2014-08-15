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
//  GTLAnalyticsCustomDataSource.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Google Analytics API (analytics/v3)
// Description:
//   View and manage your Google Analytics data
// Documentation:
//   https://developers.google.com/analytics/
// Classes:
//   GTLAnalyticsCustomDataSource (0 custom class methods, 15 custom properties)
//   GTLAnalyticsCustomDataSourceChildLink (0 custom class methods, 2 custom properties)
//   GTLAnalyticsCustomDataSourceParentLink (0 custom class methods, 2 custom properties)

#import "GTLAnalyticsCustomDataSource.h"

// ----------------------------------------------------------------------------
//
//   GTLAnalyticsCustomDataSource
//

@implementation GTLAnalyticsCustomDataSource
@dynamic accountId, childLink, created, descriptionProperty, identifier,
         importBehavior, kind, name, parentLink, profilesLinked, selfLink, type,
         updated, uploadType, webPropertyId;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObjectsAndKeys:
      @"description", @"descriptionProperty",
      @"id", @"identifier",
      nil];
  return map;
}

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:[NSString class]
                                forKey:@"profilesLinked"];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"analytics#customDataSource"];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLAnalyticsCustomDataSourceChildLink
//

@implementation GTLAnalyticsCustomDataSourceChildLink
@dynamic href, type;
@end


// ----------------------------------------------------------------------------
//
//   GTLAnalyticsCustomDataSourceParentLink
//

@implementation GTLAnalyticsCustomDataSourceParentLink
@dynamic href, type;
@end
