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
//  GTLComputeKernelList.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Compute Engine API (compute/v1beta14)
// Description:
//   API for the Google Compute Engine service.
// Documentation:
//   https://developers.google.com/compute/docs/reference/v1beta14
// Classes:
//   GTLComputeKernelList (0 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLComputeKernel;

// ----------------------------------------------------------------------------
//
//   GTLComputeKernelList
//

// Contains a list of kernel resources.

// This class supports NSFastEnumeration over its "items" property. It also
// supports -itemAtIndex: to retrieve individual objects from "items".

@interface GTLComputeKernelList : GTLCollectionObject

// Unique identifier for the resource; defined by the server (output only).
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (copy) NSString *identifier;

// The kernel resources.
@property (retain) NSArray *items;  // of GTLComputeKernel

// Type of resource.
@property (copy) NSString *kind;

// A token used to continue a truncated list request (output only).
@property (copy) NSString *nextPageToken;

// Server defined URL for this resource (output only).
@property (copy) NSString *selfLink;

@end
