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
//  GTLAnalyticsUnsampledReports.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Google Analytics API (analytics/v3)
// Description:
//   View and manage your Google Analytics data
// Documentation:
//   https://developers.google.com/analytics/
// Classes:
//   GTLAnalyticsUnsampledReports (0 custom class methods, 8 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLAnalyticsUnsampledReport;

// ----------------------------------------------------------------------------
//
//   GTLAnalyticsUnsampledReports
//

// An unsampled report collection lists Analytics unsampled reports to which the
// user has access. Each view (profile) can have a set of unsampled reports.
// Each resource in the unsampled report collection corresponds to a single
// Analytics unsampled report.

// This class supports NSFastEnumeration over its "items" property. It also
// supports -itemAtIndex: to retrieve individual objects from "items".

@interface GTLAnalyticsUnsampledReports : GTLCollectionObject

// A list of unsampled reports.
@property (retain) NSArray *items;  // of GTLAnalyticsUnsampledReport

// The maximum number of resources the response can contain, regardless of the
// actual number of resources returned. Its value ranges from 1 to 1000 with a
// value of 1000 by default, or otherwise specified by the max-results query
// parameter.
@property (retain) NSNumber *itemsPerPage;  // intValue

// Collection type.
@property (copy) NSString *kind;

// Link to next page for this unsampled report collection.
@property (copy) NSString *nextLink;

// Link to previous page for this unsampled report collection.
@property (copy) NSString *previousLink;

// The starting index of the resources, which is 1 by default or otherwise
// specified by the start-index query parameter.
@property (retain) NSNumber *startIndex;  // intValue

// The total number of results for the query, regardless of the number of
// resources in the result.
@property (retain) NSNumber *totalResults;  // intValue

// Email ID of the authenticated user
@property (copy) NSString *username;

@end
