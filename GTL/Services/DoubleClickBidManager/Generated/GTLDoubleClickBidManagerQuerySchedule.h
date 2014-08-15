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
//  GTLDoubleClickBidManagerQuerySchedule.h
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
//   GTLDoubleClickBidManagerQuerySchedule (0 custom class methods, 4 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLDoubleClickBidManagerQuerySchedule
//

// Information on how frequently and when to run a query.

@interface GTLDoubleClickBidManagerQuerySchedule : GTLObject

// Datetime to periodically run the query until.
@property (retain) NSNumber *endTimeMs;  // longLongValue

// How often the query is run.
@property (copy) NSString *frequency;

// Time of day at which a new report will be generated, represented as minutes
// past midnight Range is 0 to 1439. Only applies to scheduled reports.
@property (retain) NSNumber *nextRunMinuteOfDay;  // intValue

// Canonical timezone code for report generation time. Defaults to
// America/New_York.
@property (copy) NSString *nextRunTimezoneCode;

@end
