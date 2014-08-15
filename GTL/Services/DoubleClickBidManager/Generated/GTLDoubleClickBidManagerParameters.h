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
//  GTLDoubleClickBidManagerParameters.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   DoubleClick Bid Manager API (doubleclickbidmanager/v1)
// Description:
//   API for viewing and managing your reports in DoubleClick Bid Manager.
// Documentation:
//   https://developers.google.com/bid-manager/
// Classes:
//   GTLDoubleClickBidManagerParameters (0 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLDoubleClickBidManagerFilterPair;

// ----------------------------------------------------------------------------
//
//   GTLDoubleClickBidManagerParameters
//

// Parameters of a query or report.

@interface GTLDoubleClickBidManagerParameters : GTLObject

// Filters used to match traffic data in your report.
@property (retain) NSArray *filters;  // of GTLDoubleClickBidManagerFilterPair

// Data is grouped by the filters listed in this field.
@property (retain) NSArray *groupBys;  // of NSString

// Whether to include data from Invite Media.
@property (retain) NSNumber *includeInviteData;  // boolValue

// Metrics to include as columns in your report.
@property (retain) NSArray *metrics;  // of NSString

// Report type.
@property (copy) NSString *type;

@end
