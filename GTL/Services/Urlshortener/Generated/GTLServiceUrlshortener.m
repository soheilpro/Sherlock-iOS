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
//  GTLServiceUrlshortener.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   URL Shortener API (urlshortener/v1)
// Description:
//   Lets you create, inspect, and manage goo.gl short URLs
// Documentation:
//   https://developers.google.com/url-shortener/v1/getting_started
// Classes:
//   GTLServiceUrlshortener (0 custom class methods, 0 custom properties)

#import "GTLUrlshortener.h"

@implementation GTLServiceUrlshortener

#if DEBUG
// Method compiled in debug builds just to check that all the needed support
// classes are present at link time.
+ (NSArray *)checkClasses {
  NSArray *classes = [NSArray arrayWithObjects:
                      [GTLQueryUrlshortener class],
                      [GTLUrlshortenerAnalyticsSnapshot class],
                      [GTLUrlshortenerAnalyticsSummary class],
                      [GTLUrlshortenerStringCount class],
                      [GTLUrlshortenerUrl class],
                      [GTLUrlshortenerUrlHistory class],
                      nil];
  return classes;
}
#endif  // DEBUG

- (id)init {
  self = [super init];
  if (self) {
    // Version from discovery.
    self.apiVersion = @"v1";

    // From discovery.  Where to send JSON-RPC.
    // Turn off prettyPrint for this service to save bandwidth (especially on
    // mobile). The fetcher logging will pretty print.
    self.rpcURL = [NSURL URLWithString:@"https://www.googleapis.com/rpc?prettyPrint=false"];
  }
  return self;
}

@end
