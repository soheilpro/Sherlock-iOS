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
//  GTLQueryCivicInfo.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Google Civic Information API (civicinfo/v1)
// Description:
//   An API for accessing civic information.
// Documentation:
//   https://developers.google.com/civic-information
// Classes:
//   GTLQueryCivicInfo (4 custom class methods, 8 custom properties)

#import "GTLQueryCivicInfo.h"

#import "GTLCivicInfoDivisionSearchResponse.h"
#import "GTLCivicInfoElectionsQueryResponse.h"
#import "GTLCivicInfoRepresentativeInfoResponse.h"
#import "GTLCivicInfoVoterInfoResponse.h"

@implementation GTLQueryCivicInfo

@dynamic address, electionId, fields, includeOffices, ocdId, officialOnly,
         query, recursive;

#pragma mark -
#pragma mark "divisions" methods
// These create a GTLQueryCivicInfo object.

+ (id)queryForDivisionsSearch {
  NSString *methodName = @"civicinfo.divisions.search";
  GTLQueryCivicInfo *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLCivicInfoDivisionSearchResponse class];
  return query;
}

#pragma mark -
#pragma mark "elections" methods
// These create a GTLQueryCivicInfo object.

+ (id)queryForElectionsElectionQuery {
  NSString *methodName = @"civicinfo.elections.electionQuery";
  GTLQueryCivicInfo *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLCivicInfoElectionsQueryResponse class];
  return query;
}

+ (id)queryForElectionsVoterInfoQueryWithElectionId:(long long)electionId {
  NSString *methodName = @"civicinfo.elections.voterInfoQuery";
  GTLQueryCivicInfo *query = [self queryWithMethodName:methodName];
  query.electionId = electionId;
  query.expectedObjectClass = [GTLCivicInfoVoterInfoResponse class];
  return query;
}

#pragma mark -
#pragma mark "representatives" methods
// These create a GTLQueryCivicInfo object.

+ (id)queryForRepresentativesRepresentativeInfoQuery {
  NSString *methodName = @"civicinfo.representatives.representativeInfoQuery";
  GTLQueryCivicInfo *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLCivicInfoRepresentativeInfoResponse class];
  return query;
}

@end
