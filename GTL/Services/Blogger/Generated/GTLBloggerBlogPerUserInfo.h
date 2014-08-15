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
//  GTLBloggerBlogPerUserInfo.h
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
//   GTLBloggerBlogPerUserInfo (0 custom class methods, 6 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLBloggerBlogPerUserInfo
//

@interface GTLBloggerBlogPerUserInfo : GTLObject

// ID of the Blog resource
@property (copy) NSString *blogId;

// True if the user has Admin level access to the blog.
@property (retain) NSNumber *hasAdminAccess;  // boolValue

// The kind of this entity. Always blogger#blogPerUserInfo
@property (copy) NSString *kind;

// The Photo Album Key for the user when adding photos to the blog
@property (copy) NSString *photosAlbumKey;

// Access permissions that the user has for the blog (ADMIN, AUTHOR, or READER).
@property (copy) NSString *role;

// ID of the User
@property (copy) NSString *userId;

@end
