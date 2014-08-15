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
//  GTLAdSensePayments.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   AdSense Management API (adsense/v1.4)
// Description:
//   Gives AdSense publishers access to their inventory and the ability to
//   generate reports
// Documentation:
//   https://developers.google.com/adsense/management/
// Classes:
//   GTLAdSensePayments (0 custom class methods, 2 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLAdSensePayment;

// ----------------------------------------------------------------------------
//
//   GTLAdSensePayments
//

// This class supports NSFastEnumeration over its "items" property. It also
// supports -itemAtIndex: to retrieve individual objects from "items".

@interface GTLAdSensePayments : GTLCollectionObject

// The list of Payments for the account. One or both of a) the account's most
// recent payment; and b) the account's upcoming payment.
@property (retain) NSArray *items;  // of GTLAdSensePayment

// Kind of list this is, in this case adsense#payments.
@property (copy) NSString *kind;

@end
