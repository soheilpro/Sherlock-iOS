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
//  GTLCivicInfoDivisionSearchResponse.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Google Civic Information API (civicinfo/v2)
// Description:
//   An API for accessing civic information.
// Documentation:
//   https://developers.google.com/civic-information
// Classes:
//   GTLCivicInfoDivisionSearchResponse (0 custom class methods, 2 custom properties)

#import "GTLCivicInfoDivisionSearchResponse.h"

#import "GTLCivicInfoDivisionSearchResult.h"

// ----------------------------------------------------------------------------
//
//   GTLCivicInfoDivisionSearchResponse
//

@implementation GTLCivicInfoDivisionSearchResponse
@dynamic kind, results;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:[GTLCivicInfoDivisionSearchResult class]
                                forKey:@"results"];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"civicinfo#divisionSearchResponse"];
}

@end
