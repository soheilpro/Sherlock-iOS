/* Copyright (c) 2012 Google Inc.
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
//  GTLCalendarAclRule.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Calendar API (calendar/v3)
// Description:
//   Lets you manipulate events and other calendar data.
// Documentation:
//   https://developers.google.com/google-apps/calendar/firstapp
// Classes:
//   GTLCalendarAclRule (0 custom class methods, 5 custom properties)
//   GTLCalendarAclRuleScope (0 custom class methods, 2 custom properties)

#import "GTLCalendarAclRule.h"

// ----------------------------------------------------------------------------
//
//   GTLCalendarAclRule
//

@implementation GTLCalendarAclRule
@dynamic ETag, identifier, kind, role, scope;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObjectsAndKeys:
      @"etag", @"ETag",
      @"id", @"identifier",
      nil];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"calendar#aclRule"];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLCalendarAclRuleScope
//

@implementation GTLCalendarAclRuleScope
@dynamic type, value;
@end
