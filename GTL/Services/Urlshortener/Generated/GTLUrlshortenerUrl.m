/* Copyright (c) 2011 Google Inc.
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
//  GTLUrlshortenerUrl.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   URL Shortener API (urlshortener/v1)
// Description:
//   Lets you create, inspect, and manage goo.gl short URLs
// Documentation:
//   http://code.google.com/apis/urlshortener/v1/getting_started.html
// Classes:
//   GTLUrlshortenerUrl (0 custom class methods, 6 custom properties)

#import "GTLUrlshortenerUrl.h"

#import "GTLUrlshortenerAnalyticsSummary.h"

// ----------------------------------------------------------------------------
//
//   GTLUrlshortenerUrl
//

@implementation GTLUrlshortenerUrl
@dynamic analytics, created, identifier, kind, longUrl, status;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"id"
                                forKey:@"identifier"];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"urlshortener#url"];
}

@end
