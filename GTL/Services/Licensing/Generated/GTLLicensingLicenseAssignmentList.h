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
//  GTLLicensingLicenseAssignmentList.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Enterprise License Manager API (licensing/v1)
// Description:
//   Licensing API to view and manage license for your domain.
// Documentation:
//   https://developers.google.com/google-apps/licensing/
// Classes:
//   GTLLicensingLicenseAssignmentList (0 custom class methods, 4 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLLicensingLicenseAssignment;

// ----------------------------------------------------------------------------
//
//   GTLLicensingLicenseAssignmentList
//

// LicesnseAssignment List for a given product/sku for a customer.

// This class supports NSFastEnumeration over its "items" property. It also
// supports -itemAtIndex: to retrieve individual objects from "items".

@interface GTLLicensingLicenseAssignmentList : GTLCollectionObject

// ETag of the resource.
@property (copy) NSString *ETag;

// The LicenseAssignments in this page of results.
@property (retain) NSArray *items;  // of GTLLicensingLicenseAssignment

// Identifies the resource as a collection of LicenseAssignments.
@property (copy) NSString *kind;

// The continuation token, used to page through large result sets. Provide this
// value in a subsequent request to return the next page of results.
@property (copy) NSString *nextPageToken;

@end
