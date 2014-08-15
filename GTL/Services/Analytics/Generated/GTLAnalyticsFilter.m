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
//  GTLAnalyticsFilter.m
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
//   GTLAnalyticsFilter (0 custom class methods, 15 custom properties)
//   GTLAnalyticsFilterAdvancedDetails (0 custom class methods, 10 custom properties)
//   GTLAnalyticsFilterLowercaseDetails (0 custom class methods, 1 custom properties)
//   GTLAnalyticsFilterParentLink (0 custom class methods, 2 custom properties)
//   GTLAnalyticsFilterSearchAndReplaceDetails (0 custom class methods, 4 custom properties)
//   GTLAnalyticsFilterUppercaseDetails (0 custom class methods, 1 custom properties)

#import "GTLAnalyticsFilter.h"

#import "GTLAnalyticsFilterExpression.h"

// ----------------------------------------------------------------------------
//
//   GTLAnalyticsFilter
//

@implementation GTLAnalyticsFilter
@dynamic accountId, advancedDetails, created, excludeDetails, identifier,
         includeDetails, kind, lowercaseDetails, name, parentLink,
         searchAndReplaceDetails, selfLink, type, updated, uppercaseDetails;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"id"
                                forKey:@"identifier"];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"analytics#filter"];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLAnalyticsFilterAdvancedDetails
//

@implementation GTLAnalyticsFilterAdvancedDetails
@dynamic caseSensitive, extractA, extractB, fieldA, fieldARequired, fieldB,
         fieldBRequired, outputConstructor, outputToField, overrideOutputField;
@end


// ----------------------------------------------------------------------------
//
//   GTLAnalyticsFilterLowercaseDetails
//

@implementation GTLAnalyticsFilterLowercaseDetails
@dynamic field;
@end


// ----------------------------------------------------------------------------
//
//   GTLAnalyticsFilterParentLink
//

@implementation GTLAnalyticsFilterParentLink
@dynamic href, type;
@end


// ----------------------------------------------------------------------------
//
//   GTLAnalyticsFilterSearchAndReplaceDetails
//

@implementation GTLAnalyticsFilterSearchAndReplaceDetails
@dynamic caseSensitive, field, replaceString, searchString;
@end


// ----------------------------------------------------------------------------
//
//   GTLAnalyticsFilterUppercaseDetails
//

@implementation GTLAnalyticsFilterUppercaseDetails
@dynamic field;
@end
