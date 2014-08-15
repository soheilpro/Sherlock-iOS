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
//  GTLOrkutCommunityMessage.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Orkut API (orkut/v2)
// Description:
//   Lets you manage activities, comments and badges in Orkut. More stuff coming
//   in time.
// Documentation:
//   http://code.google.com/apis/orkut/v2/reference.html
// Classes:
//   GTLOrkutCommunityMessage (0 custom class methods, 8 custom properties)

#import "GTLOrkutCommunityMessage.h"

#import "GTLOrkutAuthorResource.h"
#import "GTLOrkutLinkResource.h"

// ----------------------------------------------------------------------------
//
//   GTLOrkutCommunityMessage
//

@implementation GTLOrkutCommunityMessage
@dynamic addedDate, author, body, identifier, isSpam, kind, links, subject;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"id"
                                forKey:@"identifier"];
  return map;
}

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:[GTLOrkutLinkResource class]
                                forKey:@"links"];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"orkut#communityMessage"];
}

@end
