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
//  GTLGmailListHistoryResponse.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Gmail API (gmail/v1)
// Description:
//   The Gmail REST API.
// Documentation:
//   https://developers.google.com/gmail/api/
// Classes:
//   GTLGmailListHistoryResponse (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLGmailHistory;

// ----------------------------------------------------------------------------
//
//   GTLGmailListHistoryResponse
//

@interface GTLGmailListHistoryResponse : GTLObject

// List of history records.
@property (retain) NSArray *history;  // of GTLGmailHistory

// The ID of the mailbox's current history record.
@property (retain) NSNumber *historyId;  // unsignedLongLongValue

// Page token to retrieve the next page of results in the list.
@property (copy) NSString *nextPageToken;

@end
