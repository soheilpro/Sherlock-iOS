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
//  GTLBigqueryTableDataInsertAllResponse.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   BigQuery API (bigquery/v2)
// Description:
//   A data platform for customers to create, manage, share and query data.
// Documentation:
//   https://developers.google.com/bigquery/docs/overview
// Classes:
//   GTLBigqueryTableDataInsertAllResponse (0 custom class methods, 2 custom properties)
//   GTLBigqueryTableDataInsertAllResponseInsertErrorsItem (0 custom class methods, 2 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLBigqueryErrorProto;
@class GTLBigqueryTableDataInsertAllResponseInsertErrorsItem;

// ----------------------------------------------------------------------------
//
//   GTLBigqueryTableDataInsertAllResponse
//

@interface GTLBigqueryTableDataInsertAllResponse : GTLObject

// An array of errors for rows that were not inserted.
@property (retain) NSArray *insertErrors;  // of GTLBigqueryTableDataInsertAllResponseInsertErrorsItem

// The resource type of the response.
@property (copy) NSString *kind;

@end


// ----------------------------------------------------------------------------
//
//   GTLBigqueryTableDataInsertAllResponseInsertErrorsItem
//

@interface GTLBigqueryTableDataInsertAllResponseInsertErrorsItem : GTLObject

// Error information for the row indicated by the index property.
@property (retain) NSArray *errors;  // of GTLBigqueryErrorProto

// The index of the row that error applies to.
@property (retain) NSNumber *index;  // unsignedIntValue

@end
