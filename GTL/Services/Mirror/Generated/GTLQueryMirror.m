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
//  GTLQueryMirror.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Google Mirror API (mirror/v1)
// Description:
//   API for interacting with Glass users via the timeline.
// Documentation:
//   https://developers.google.com/glass
// Classes:
//   GTLQueryMirror (24 custom class methods, 14 custom properties)

#import "GTLQueryMirror.h"

#import "GTLMirrorAccount.h"
#import "GTLMirrorAttachment.h"
#import "GTLMirrorAttachmentsListResponse.h"
#import "GTLMirrorContact.h"
#import "GTLMirrorContactsListResponse.h"
#import "GTLMirrorLocation.h"
#import "GTLMirrorLocationsListResponse.h"
#import "GTLMirrorSetting.h"
#import "GTLMirrorSubscription.h"
#import "GTLMirrorSubscriptionsListResponse.h"
#import "GTLMirrorTimelineItem.h"
#import "GTLMirrorTimelineListResponse.h"

@implementation GTLQueryMirror

@dynamic accountName, accountType, attachmentId, bundleId, fields, identifier,
         includeDeleted, itemId, maxResults, orderBy, pageToken, pinnedOnly,
         sourceItemId, userToken;

+ (NSDictionary *)parameterNameMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"id"
                                forKey:@"identifier"];
  return map;
}

#pragma mark -
#pragma mark "accounts" methods
// These create a GTLQueryMirror object.

+ (id)queryForAccountsInsertWithObject:(GTLMirrorAccount *)object
                             userToken:(NSString *)userToken
                           accountType:(NSString *)accountType
                           accountName:(NSString *)accountName {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"mirror.accounts.insert";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.userToken = userToken;
  query.accountType = accountType;
  query.accountName = accountName;
  query.expectedObjectClass = [GTLMirrorAccount class];
  return query;
}

#pragma mark -
#pragma mark "contacts" methods
// These create a GTLQueryMirror object.

+ (id)queryForContactsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"mirror.contacts.delete";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForContactsGetWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"mirror.contacts.get";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.expectedObjectClass = [GTLMirrorContact class];
  return query;
}

+ (id)queryForContactsInsertWithObject:(GTLMirrorContact *)object {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"mirror.contacts.insert";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLMirrorContact class];
  return query;
}

+ (id)queryForContactsList {
  NSString *methodName = @"mirror.contacts.list";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLMirrorContactsListResponse class];
  return query;
}

+ (id)queryForContactsPatchWithObject:(GTLMirrorContact *)object
                           identifier:(NSString *)identifier {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"mirror.contacts.patch";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.identifier = identifier;
  query.expectedObjectClass = [GTLMirrorContact class];
  return query;
}

+ (id)queryForContactsUpdateWithObject:(GTLMirrorContact *)object
                            identifier:(NSString *)identifier {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"mirror.contacts.update";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.identifier = identifier;
  query.expectedObjectClass = [GTLMirrorContact class];
  return query;
}

#pragma mark -
#pragma mark "locations" methods
// These create a GTLQueryMirror object.

+ (id)queryForLocationsGetWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"mirror.locations.get";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.expectedObjectClass = [GTLMirrorLocation class];
  return query;
}

+ (id)queryForLocationsList {
  NSString *methodName = @"mirror.locations.list";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLMirrorLocationsListResponse class];
  return query;
}

#pragma mark -
#pragma mark "settings" methods
// These create a GTLQueryMirror object.

+ (id)queryForSettingsGetWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"mirror.settings.get";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.expectedObjectClass = [GTLMirrorSetting class];
  return query;
}

#pragma mark -
#pragma mark "subscriptions" methods
// These create a GTLQueryMirror object.

+ (id)queryForSubscriptionsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"mirror.subscriptions.delete";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForSubscriptionsInsertWithObject:(GTLMirrorSubscription *)object {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"mirror.subscriptions.insert";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLMirrorSubscription class];
  return query;
}

+ (id)queryForSubscriptionsList {
  NSString *methodName = @"mirror.subscriptions.list";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLMirrorSubscriptionsListResponse class];
  return query;
}

+ (id)queryForSubscriptionsUpdateWithObject:(GTLMirrorSubscription *)object
                                 identifier:(NSString *)identifier {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"mirror.subscriptions.update";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.identifier = identifier;
  query.expectedObjectClass = [GTLMirrorSubscription class];
  return query;
}

#pragma mark -
#pragma mark "timeline.attachments" methods
// These create a GTLQueryMirror object.

+ (id)queryForTimelineAttachmentsDeleteWithItemId:(NSString *)itemId
                                     attachmentId:(NSString *)attachmentId {
  NSString *methodName = @"mirror.timeline.attachments.delete";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.itemId = itemId;
  query.attachmentId = attachmentId;
  return query;
}

+ (id)queryForTimelineAttachmentsGetWithItemId:(NSString *)itemId
                                  attachmentId:(NSString *)attachmentId {
  NSString *methodName = @"mirror.timeline.attachments.get";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.itemId = itemId;
  query.attachmentId = attachmentId;
  query.expectedObjectClass = [GTLMirrorAttachment class];
  return query;
}

+ (id)queryForTimelineAttachmentsInsertWithItemId:(NSString *)itemId
                                 uploadParameters:(GTLUploadParameters *)uploadParametersOrNil {
  NSString *methodName = @"mirror.timeline.attachments.insert";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.itemId = itemId;
  query.uploadParameters = uploadParametersOrNil;
  query.expectedObjectClass = [GTLMirrorAttachment class];
  return query;
}

+ (id)queryForTimelineAttachmentsListWithItemId:(NSString *)itemId {
  NSString *methodName = @"mirror.timeline.attachments.list";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.itemId = itemId;
  query.expectedObjectClass = [GTLMirrorAttachmentsListResponse class];
  return query;
}

#pragma mark -
#pragma mark "timeline" methods
// These create a GTLQueryMirror object.

+ (id)queryForTimelineDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"mirror.timeline.delete";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForTimelineGetWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"mirror.timeline.get";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.expectedObjectClass = [GTLMirrorTimelineItem class];
  return query;
}

+ (id)queryForTimelineInsertWithObject:(GTLMirrorTimelineItem *)object
                      uploadParameters:(GTLUploadParameters *)uploadParametersOrNil {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"mirror.timeline.insert";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.uploadParameters = uploadParametersOrNil;
  query.expectedObjectClass = [GTLMirrorTimelineItem class];
  return query;
}

+ (id)queryForTimelineList {
  NSString *methodName = @"mirror.timeline.list";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLMirrorTimelineListResponse class];
  return query;
}

+ (id)queryForTimelinePatchWithObject:(GTLMirrorTimelineItem *)object
                           identifier:(NSString *)identifier {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"mirror.timeline.patch";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.identifier = identifier;
  query.expectedObjectClass = [GTLMirrorTimelineItem class];
  return query;
}

+ (id)queryForTimelineUpdateWithObject:(GTLMirrorTimelineItem *)object
                            identifier:(NSString *)identifier
                      uploadParameters:(GTLUploadParameters *)uploadParametersOrNil {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"mirror.timeline.update";
  GTLQueryMirror *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.identifier = identifier;
  query.uploadParameters = uploadParametersOrNil;
  query.expectedObjectClass = [GTLMirrorTimelineItem class];
  return query;
}

@end
