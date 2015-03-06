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
//  GTLYouTubeAnalyticsBatchReport.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   YouTube Analytics API (youtubeAnalytics/v1)
// Description:
//   Retrieve your YouTube Analytics reports.
// Documentation:
//   http://developers.google.com/youtube/analytics/
// Classes:
//   GTLYouTubeAnalyticsBatchReport (0 custom class methods, 6 custom properties)
//   GTLYouTubeAnalyticsBatchReportOutputsItem (0 custom class methods, 3 custom properties)
//   GTLYouTubeAnalyticsBatchReportTimeSpan (0 custom class methods, 2 custom properties)

#import "GTLYouTubeAnalyticsBatchReport.h"

// ----------------------------------------------------------------------------
//
//   GTLYouTubeAnalyticsBatchReport
//

@implementation GTLYouTubeAnalyticsBatchReport
@dynamic identifier, kind, outputs, reportId, timeSpan, timeUpdated;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"id"
                                forKey:@"identifier"];
  return map;
}

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:[GTLYouTubeAnalyticsBatchReportOutputsItem class]
                                forKey:@"outputs"];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"youtubeAnalytics#batchReport"];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLYouTubeAnalyticsBatchReportOutputsItem
//

@implementation GTLYouTubeAnalyticsBatchReportOutputsItem
@dynamic downloadUrl, format, type;
@end


// ----------------------------------------------------------------------------
//
//   GTLYouTubeAnalyticsBatchReportTimeSpan
//

@implementation GTLYouTubeAnalyticsBatchReportTimeSpan
@dynamic endTime, startTime;
@end
