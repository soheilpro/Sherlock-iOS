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
//  GTLOrkutCommunityMembers.h
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
//   GTLOrkutCommunityMembers (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLOrkutActivitypersonResource;
@class GTLOrkutCommunityMembershipStatus;

// ----------------------------------------------------------------------------
//
//   GTLOrkutCommunityMembers
//

@interface GTLOrkutCommunityMembers : GTLObject

// Status and permissions of the user related to the community.
@property (retain) GTLOrkutCommunityMembershipStatus *communityMembershipStatus;

// Kind of this item. Always orkut#communityMembers.
@property (copy) NSString *kind;

// Description of the community member.
@property (retain) GTLOrkutActivitypersonResource *person;

@end
