/* Copyright (c) 2011 Google Inc.
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

#import <XCTest/XCTest.h>

#import "GTLFramework.h"

@interface GTLFrameworkTest : XCTestCase
@end

@implementation GTLFrameworkTest

- (void)testFrameworkVersion {

  NSUInteger major = NSUIntegerMax;
  NSUInteger minor = NSUIntegerMax;
  NSUInteger release = NSUIntegerMax;

  GTLFrameworkVersion(&major, &minor, &release);

  XCTAssertTrue(major != NSUIntegerMax, @"version unset");
  XCTAssertTrue(minor != NSUIntegerMax, @"version unset");
  XCTAssertTrue(release != NSUIntegerMax, @"version unset");

  // Check that the Framework bundle's Info.plist has the proper version,
  // matching the GTLFrameworkVersion call
  //
  // Note: we're assuming that the current directory when this unit
  // test runs is the framework's Source directory/

  NSString *plistPath = @"Resources/GTLFramework-Info.plist";
  NSDictionary *infoDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  XCTAssertNotNil(infoDict, @"Could not find GTLFramework-Info.plist");

  if (infoDict) {

    NSString *binaryVersionStr = GTLFrameworkVersionString();

    NSString *plistVersionStr = [infoDict valueForKey:@"CFBundleVersion"];

    XCTAssertEqualObjects(plistVersionStr, binaryVersionStr,
                         @"Binary/plist version mismatch");
  }
}

@end
