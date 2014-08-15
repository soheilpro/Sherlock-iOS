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
//  GTLCalendarError.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Calendar API (calendar/v3)
// Description:
//   Lets you manipulate events and other calendar data.
// Documentation:
//   https://developers.google.com/google-apps/calendar/firstapp
// Classes:
//   GTLCalendarError (0 custom class methods, 2 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLCalendarError
//

@interface GTLCalendarError : GTLObject

// Domain, or broad category, of the error.
@property (copy) NSString *domain;

// Specific reason for the error. Some of the possible values are:
// - "groupTooBig" - The group of users requested is too large for a single
// query.
// - "tooManyCalendarsRequested" - The number of calendars requested is too
// large for a single query.
// - "notFound" - The requested resource was not found.
// - "internalError" - The API service has encountered an internal error.
// Additional error types may be added in the future, so clients should
// gracefully handle additional error statuses not included in this list.
@property (copy) NSString *reason;

@end
