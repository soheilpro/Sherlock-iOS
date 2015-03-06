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
//  GTLServiceBooks.m
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
//   GTLServiceBooks (0 custom class methods, 0 custom properties)

#import "GTLBooks.h"

@implementation GTLServiceBooks

#if DEBUG
// Method compiled in debug builds just to check that all the needed support
// classes are present at link time.
+ (NSArray *)checkClasses {
  NSArray *classes = [NSArray arrayWithObjects:
                      [GTLQueryBooks class],
                      [GTLBooksAnnotation class],
                      [GTLBooksAnnotationdata class],
                      [GTLBooksAnnotations class],
                      [GTLBooksAnnotationsdata class],
                      [GTLBooksAnnotationsRange class],
                      [GTLBooksAnnotationsSummary class],
                      [GTLBooksBookshelf class],
                      [GTLBooksBookshelves class],
                      [GTLBooksCategory class],
                      [GTLBooksCloudloadingResource class],
                      [GTLBooksConcurrentAccessRestriction class],
                      [GTLBooksDictlayerdata class],
                      [GTLBooksDownloadAccesses class],
                      [GTLBooksDownloadAccessRestriction class],
                      [GTLBooksGeolayerdata class],
                      [GTLBooksLayersummaries class],
                      [GTLBooksLayersummary class],
                      [GTLBooksMetadata class],
                      [GTLBooksOffers class],
                      [GTLBooksReadingPosition class],
                      [GTLBooksRequestAccess class],
                      [GTLBooksReview class],
                      [GTLBooksUsersettings class],
                      [GTLBooksVolume class],
                      [GTLBooksVolume2 class],
                      [GTLBooksVolumeannotation class],
                      [GTLBooksVolumeannotations class],
                      [GTLBooksVolumes class],
                      [GTLBooksVolumesRecommendedRateResponse class],
                      nil];
  return classes;
}
#endif  // DEBUG

- (id)init {
  self = [super init];
  if (self) {
    // Version from discovery.
    self.apiVersion = @"v1";

    // From discovery.  Where to send JSON-RPC.
    // Turn off prettyPrint for this service to save bandwidth (especially on
    // mobile). The fetcher logging will pretty print.
    self.rpcURL = [NSURL URLWithString:@"https://www.googleapis.com/rpc?prettyPrint=false"];
  }
  return self;
}

@end
