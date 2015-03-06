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
//  GTLQueryBooks.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Books API (books/v1)
// Description:
//   Lets you search for books and manage your Google Books library.
// Documentation:
//   https://developers.google.com/books/docs/v1/getting_started
// Classes:
//   GTLQueryBooks (45 custom class methods, 69 custom properties)

#import "GTLQueryBooks.h"

#import "GTLBooksAnnotation.h"
#import "GTLBooksAnnotationdata.h"
#import "GTLBooksAnnotations.h"
#import "GTLBooksAnnotationsdata.h"
#import "GTLBooksAnnotationsSummary.h"
#import "GTLBooksBookshelf.h"
#import "GTLBooksBookshelves.h"
#import "GTLBooksCategory.h"
#import "GTLBooksCloudloadingResource.h"
#import "GTLBooksDownloadAccesses.h"
#import "GTLBooksLayersummaries.h"
#import "GTLBooksLayersummary.h"
#import "GTLBooksMetadata.h"
#import "GTLBooksOffers.h"
#import "GTLBooksReadingPosition.h"
#import "GTLBooksRequestAccess.h"
#import "GTLBooksUsersettings.h"
#import "GTLBooksVolume.h"
#import "GTLBooksVolume2.h"
#import "GTLBooksVolumeannotation.h"
#import "GTLBooksVolumeannotations.h"
#import "GTLBooksVolumes.h"
#import "GTLBooksVolumesRecommendedRateResponse.h"

@implementation GTLQueryBooks

@dynamic acquireMethod, action, allowWebDefinitions, androidId,
         annotationDataId, annotationId, association, categoryId,
         contentVersion, country, cpksver, device, deviceCookie, download,
         driveDocumentId, endOffset, endPosition, features, fields, filter, h,
         langRestrict, layerId, layerIds, libraryRestrict, licenseTypes, locale,
         manufacturer, maxResults, mimeType, model, name, nonce, offerId,
         orderBy, pageIds, pageSize, pageToken, partner, position, printType,
         processingState, product, projection, q, rating, reason, scale, serial,
         settings, shelf, showDeleted, showOnlySummaryInResponse, showPreorders,
         source, startIndex, startOffset, startPosition, summaryId, timestamp,
         updatedMax, updatedMin, uploadClientToken, userId,
         volumeAnnotationsVersion, volumeId, volumeIds, volumePosition, w;

+ (NSDictionary *)parameterNameMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObjectsAndKeys:
      @"drive_document_id", @"driveDocumentId",
      @"mime_type", @"mimeType",
      @"upload_client_token", @"uploadClientToken",
      nil];
  return map;
}

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObjectsAndKeys:
      [NSString class], @"acquireMethod",
      [NSString class], @"categoryId",
      [NSString class], @"features",
      [NSString class], @"layerIds",
      [NSString class], @"pageIds",
      [NSString class], @"processingState",
      [NSString class], @"volumeIds",
      nil];
  return map;
}

#pragma mark -
#pragma mark "bookshelves" methods
// These create a GTLQueryBooks object.

+ (id)queryForBookshelvesGetWithUserId:(NSString *)userId
                                 shelf:(NSString *)shelf {
  NSString *methodName = @"books.bookshelves.get";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.userId = userId;
  query.shelf = shelf;
  query.expectedObjectClass = [GTLBooksBookshelf class];
  return query;
}

+ (id)queryForBookshelvesListWithUserId:(NSString *)userId {
  NSString *methodName = @"books.bookshelves.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.userId = userId;
  query.expectedObjectClass = [GTLBooksBookshelves class];
  return query;
}

#pragma mark -
#pragma mark "bookshelves.volumes" methods
// These create a GTLQueryBooks object.

+ (id)queryForBookshelvesVolumesListWithUserId:(NSString *)userId
                                         shelf:(NSString *)shelf {
  NSString *methodName = @"books.bookshelves.volumes.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.userId = userId;
  query.shelf = shelf;
  query.expectedObjectClass = [GTLBooksVolumes class];
  return query;
}

#pragma mark -
#pragma mark "cloudloading" methods
// These create a GTLQueryBooks object.

+ (id)queryForCloudloadingAddBook {
  NSString *methodName = @"books.cloudloading.addBook";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLBooksCloudloadingResource class];
  return query;
}

+ (id)queryForCloudloadingDeleteBookWithVolumeId:(NSString *)volumeId {
  NSString *methodName = @"books.cloudloading.deleteBook";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeId = volumeId;
  return query;
}

+ (id)queryForCloudloadingUpdateBookWithObject:(GTLBooksCloudloadingResource *)object {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"books.cloudloading.updateBook";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLBooksCloudloadingResource class];
  return query;
}

#pragma mark -
#pragma mark "dictionary" methods
// These create a GTLQueryBooks object.

+ (id)queryForDictionaryListOfflineMetadataWithCpksver:(NSString *)cpksver {
  NSString *methodName = @"books.dictionary.listOfflineMetadata";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.cpksver = cpksver;
  query.expectedObjectClass = [GTLBooksMetadata class];
  return query;
}

#pragma mark -
#pragma mark "layers.annotationData" methods
// These create a GTLQueryBooks object.

+ (id)queryForLayersAnnotationDataGetWithVolumeId:(NSString *)volumeId
                                          layerId:(NSString *)layerId
                                 annotationDataId:(NSString *)annotationDataId
                                   contentVersion:(NSString *)contentVersion {
  NSString *methodName = @"books.layers.annotationData.get";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeId = volumeId;
  query.layerId = layerId;
  query.annotationDataId = annotationDataId;
  query.contentVersion = contentVersion;
  query.expectedObjectClass = [GTLBooksAnnotationdata class];
  return query;
}

+ (id)queryForLayersAnnotationDataListWithVolumeId:(NSString *)volumeId
                                           layerId:(NSString *)layerId
                                    contentVersion:(NSString *)contentVersion {
  NSString *methodName = @"books.layers.annotationData.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeId = volumeId;
  query.layerId = layerId;
  query.contentVersion = contentVersion;
  query.expectedObjectClass = [GTLBooksAnnotationsdata class];
  return query;
}

#pragma mark -
#pragma mark "layers" methods
// These create a GTLQueryBooks object.

+ (id)queryForLayersGetWithVolumeId:(NSString *)volumeId
                          summaryId:(NSString *)summaryId {
  NSString *methodName = @"books.layers.get";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeId = volumeId;
  query.summaryId = summaryId;
  query.expectedObjectClass = [GTLBooksLayersummary class];
  return query;
}

+ (id)queryForLayersListWithVolumeId:(NSString *)volumeId {
  NSString *methodName = @"books.layers.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeId = volumeId;
  query.expectedObjectClass = [GTLBooksLayersummaries class];
  return query;
}

#pragma mark -
#pragma mark "layers.volumeAnnotations" methods
// These create a GTLQueryBooks object.

+ (id)queryForLayersVolumeAnnotationsGetWithVolumeId:(NSString *)volumeId
                                             layerId:(NSString *)layerId
                                        annotationId:(NSString *)annotationId {
  NSString *methodName = @"books.layers.volumeAnnotations.get";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeId = volumeId;
  query.layerId = layerId;
  query.annotationId = annotationId;
  query.expectedObjectClass = [GTLBooksVolumeannotation class];
  return query;
}

+ (id)queryForLayersVolumeAnnotationsListWithVolumeId:(NSString *)volumeId
                                              layerId:(NSString *)layerId
                                       contentVersion:(NSString *)contentVersion {
  NSString *methodName = @"books.layers.volumeAnnotations.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeId = volumeId;
  query.layerId = layerId;
  query.contentVersion = contentVersion;
  query.expectedObjectClass = [GTLBooksVolumeannotations class];
  return query;
}

#pragma mark -
#pragma mark "myconfig" methods
// These create a GTLQueryBooks object.

+ (id)queryForMyconfigGetUserSettings {
  NSString *methodName = @"books.myconfig.getUserSettings";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLBooksUsersettings class];
  return query;
}

+ (id)queryForMyconfigReleaseDownloadAccessWithVolumeIds:(NSArray *)volumeIds
                                                 cpksver:(NSString *)cpksver {
  NSString *methodName = @"books.myconfig.releaseDownloadAccess";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeIds = volumeIds;
  query.cpksver = cpksver;
  query.expectedObjectClass = [GTLBooksDownloadAccesses class];
  return query;
}

+ (id)queryForMyconfigRequestAccessWithSource:(NSString *)source
                                     volumeId:(NSString *)volumeId
                                        nonce:(NSString *)nonce
                                      cpksver:(NSString *)cpksver {
  NSString *methodName = @"books.myconfig.requestAccess";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.source = source;
  query.volumeId = volumeId;
  query.nonce = nonce;
  query.cpksver = cpksver;
  query.expectedObjectClass = [GTLBooksRequestAccess class];
  return query;
}

+ (id)queryForMyconfigSyncVolumeLicensesWithSource:(NSString *)source
                                             nonce:(NSString *)nonce
                                           cpksver:(NSString *)cpksver {
  NSString *methodName = @"books.myconfig.syncVolumeLicenses";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.source = source;
  query.nonce = nonce;
  query.cpksver = cpksver;
  query.expectedObjectClass = [GTLBooksVolumes class];
  return query;
}

+ (id)queryForMyconfigUpdateUserSettings {
  NSString *methodName = @"books.myconfig.updateUserSettings";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLBooksUsersettings class];
  return query;
}

#pragma mark -
#pragma mark "mylibrary.annotations" methods
// These create a GTLQueryBooks object.

+ (id)queryForMylibraryAnnotationsDeleteWithAnnotationId:(NSString *)annotationId {
  NSString *methodName = @"books.mylibrary.annotations.delete";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.annotationId = annotationId;
  return query;
}

+ (id)queryForMylibraryAnnotationsGetWithAnnotationId:(NSString *)annotationId {
  NSString *methodName = @"books.mylibrary.annotations.get";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.annotationId = annotationId;
  query.expectedObjectClass = [GTLBooksAnnotation class];
  return query;
}

+ (id)queryForMylibraryAnnotationsInsertWithObject:(GTLBooksAnnotation *)object {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"books.mylibrary.annotations.insert";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLBooksAnnotation class];
  return query;
}

+ (id)queryForMylibraryAnnotationsList {
  NSString *methodName = @"books.mylibrary.annotations.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLBooksAnnotations class];
  return query;
}

+ (id)queryForMylibraryAnnotationsSummaryWithLayerIds:(NSArray *)layerIds
                                             volumeId:(NSString *)volumeId {
  NSString *methodName = @"books.mylibrary.annotations.summary";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.layerIds = layerIds;
  query.volumeId = volumeId;
  query.expectedObjectClass = [GTLBooksAnnotationsSummary class];
  return query;
}

+ (id)queryForMylibraryAnnotationsUpdateWithObject:(GTLBooksAnnotation *)object
                                      annotationId:(NSString *)annotationId {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"books.mylibrary.annotations.update";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.annotationId = annotationId;
  query.expectedObjectClass = [GTLBooksAnnotation class];
  return query;
}

#pragma mark -
#pragma mark "mylibrary.bookshelves" methods
// These create a GTLQueryBooks object.

+ (id)queryForMylibraryBookshelvesAddVolumeWithShelf:(NSString *)shelf
                                            volumeId:(NSString *)volumeId {
  NSString *methodName = @"books.mylibrary.bookshelves.addVolume";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.shelf = shelf;
  query.volumeId = volumeId;
  return query;
}

+ (id)queryForMylibraryBookshelvesClearVolumesWithShelf:(NSString *)shelf {
  NSString *methodName = @"books.mylibrary.bookshelves.clearVolumes";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.shelf = shelf;
  return query;
}

+ (id)queryForMylibraryBookshelvesGetWithShelf:(NSString *)shelf {
  NSString *methodName = @"books.mylibrary.bookshelves.get";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.shelf = shelf;
  query.expectedObjectClass = [GTLBooksBookshelf class];
  return query;
}

+ (id)queryForMylibraryBookshelvesList {
  NSString *methodName = @"books.mylibrary.bookshelves.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLBooksBookshelves class];
  return query;
}

+ (id)queryForMylibraryBookshelvesMoveVolumeWithShelf:(NSString *)shelf
                                             volumeId:(NSString *)volumeId
                                       volumePosition:(NSInteger)volumePosition {
  NSString *methodName = @"books.mylibrary.bookshelves.moveVolume";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.shelf = shelf;
  query.volumeId = volumeId;
  query.volumePosition = volumePosition;
  return query;
}

+ (id)queryForMylibraryBookshelvesRemoveVolumeWithShelf:(NSString *)shelf
                                               volumeId:(NSString *)volumeId {
  NSString *methodName = @"books.mylibrary.bookshelves.removeVolume";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.shelf = shelf;
  query.volumeId = volumeId;
  return query;
}

#pragma mark -
#pragma mark "mylibrary.bookshelves.volumes" methods
// These create a GTLQueryBooks object.

+ (id)queryForMylibraryBookshelvesVolumesListWithShelf:(NSString *)shelf {
  NSString *methodName = @"books.mylibrary.bookshelves.volumes.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.shelf = shelf;
  query.expectedObjectClass = [GTLBooksVolumes class];
  return query;
}

#pragma mark -
#pragma mark "mylibrary.readingpositions" methods
// These create a GTLQueryBooks object.

+ (id)queryForMylibraryReadingpositionsGetWithVolumeId:(NSString *)volumeId {
  NSString *methodName = @"books.mylibrary.readingpositions.get";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeId = volumeId;
  query.expectedObjectClass = [GTLBooksReadingPosition class];
  return query;
}

+ (id)queryForMylibraryReadingpositionsSetPositionWithVolumeId:(NSString *)volumeId
                                                     timestamp:(NSString *)timestamp
                                                      position:(NSString *)position {
  NSString *methodName = @"books.mylibrary.readingpositions.setPosition";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeId = volumeId;
  query.timestamp = timestamp;
  query.position = position;
  return query;
}

#pragma mark -
#pragma mark "onboarding" methods
// These create a GTLQueryBooks object.

+ (id)queryForOnboardingListCategories {
  NSString *methodName = @"books.onboarding.listCategories";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLBooksCategory class];
  return query;
}

+ (id)queryForOnboardingListCategoryVolumes {
  NSString *methodName = @"books.onboarding.listCategoryVolumes";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLBooksVolume2 class];
  return query;
}

#pragma mark -
#pragma mark "promooffer" methods
// These create a GTLQueryBooks object.

+ (id)queryForPromoofferAccept {
  NSString *methodName = @"books.promooffer.accept";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  return query;
}

+ (id)queryForPromoofferDismiss {
  NSString *methodName = @"books.promooffer.dismiss";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  return query;
}

+ (id)queryForPromoofferGet {
  NSString *methodName = @"books.promooffer.get";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLBooksOffers class];
  return query;
}

#pragma mark -
#pragma mark "volumes.associated" methods
// These create a GTLQueryBooks object.

+ (id)queryForVolumesAssociatedListWithVolumeId:(NSString *)volumeId {
  NSString *methodName = @"books.volumes.associated.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeId = volumeId;
  query.expectedObjectClass = [GTLBooksVolumes class];
  return query;
}

#pragma mark -
#pragma mark "volumes" methods
// These create a GTLQueryBooks object.

+ (id)queryForVolumesGetWithVolumeId:(NSString *)volumeId {
  NSString *methodName = @"books.volumes.get";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.volumeId = volumeId;
  query.expectedObjectClass = [GTLBooksVolume class];
  return query;
}

+ (id)queryForVolumesListWithQ:(NSString *)q {
  NSString *methodName = @"books.volumes.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.q = q;
  query.expectedObjectClass = [GTLBooksVolumes class];
  return query;
}

#pragma mark -
#pragma mark "volumes.mybooks" methods
// These create a GTLQueryBooks object.

+ (id)queryForVolumesMybooksList {
  NSString *methodName = @"books.volumes.mybooks.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLBooksVolumes class];
  return query;
}

#pragma mark -
#pragma mark "volumes.recommended" methods
// These create a GTLQueryBooks object.

+ (id)queryForVolumesRecommendedList {
  NSString *methodName = @"books.volumes.recommended.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLBooksVolumes class];
  return query;
}

+ (id)queryForVolumesRecommendedRateWithRating:(NSString *)rating
                                      volumeId:(NSString *)volumeId {
  NSString *methodName = @"books.volumes.recommended.rate";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.rating = rating;
  query.volumeId = volumeId;
  query.expectedObjectClass = [GTLBooksVolumesRecommendedRateResponse class];
  return query;
}

#pragma mark -
#pragma mark "volumes.useruploaded" methods
// These create a GTLQueryBooks object.

+ (id)queryForVolumesUseruploadedList {
  NSString *methodName = @"books.volumes.useruploaded.list";
  GTLQueryBooks *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLBooksVolumes class];
  return query;
}

@end
