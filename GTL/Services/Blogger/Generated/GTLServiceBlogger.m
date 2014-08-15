/* Copyright (c) 2013 Google Inc.
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
//  GTLServiceBlogger.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Blogger API (blogger/v3)
// Description:
//   API for access to the data within Blogger.
// Documentation:
//   https://developers.google.com/blogger/docs/3.0/getting_started
// Classes:
//   GTLServiceBlogger (0 custom class methods, 0 custom properties)

#import "GTLBlogger.h"

@implementation GTLServiceBlogger

#if DEBUG
// Method compiled in debug builds just to check that all the needed support
// classes are present at link time.
+ (NSArray *)checkClasses {
  NSArray *classes = [NSArray arrayWithObjects:
                      [GTLQueryBlogger class],
                      [GTLBloggerBlog class],
                      [GTLBloggerBlogList class],
                      [GTLBloggerBlogPerUserInfo class],
                      [GTLBloggerBlogUserInfo class],
                      [GTLBloggerComment class],
                      [GTLBloggerCommentList class],
                      [GTLBloggerPage class],
                      [GTLBloggerPageList class],
                      [GTLBloggerPageviews class],
                      [GTLBloggerPost class],
                      [GTLBloggerPostList class],
                      [GTLBloggerPostPerUserInfo class],
                      [GTLBloggerPostUserInfo class],
                      [GTLBloggerPostUserInfosList class],
                      [GTLBloggerUser class],
                      nil];
  return classes;
}
#endif  // DEBUG

- (id)init {
  self = [super init];
  if (self) {
    // Version from discovery.
    self.apiVersion = @"v3";

    // From discovery.  Where to send JSON-RPC.
    // Turn off prettyPrint for this service to save bandwidth (especially on
    // mobile). The fetcher logging will pretty print.
    self.rpcURL = [NSURL URLWithString:@"https://www.googleapis.com/rpc?prettyPrint=false"];
  }
  return self;
}

@end
