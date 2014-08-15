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
//  GTLQPXExpressTripOption.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   QPX Express API (qpxExpress/v1)
// Description:
//   Lets you find the least expensive flights between an origin and a
//   destination.
// Documentation:
//   http://developers.google.com/qpx-express
// Classes:
//   GTLQPXExpressTripOption (0 custom class methods, 5 custom properties)

#import "GTLQPXExpressTripOption.h"

#import "GTLQPXExpressPricingInfo.h"
#import "GTLQPXExpressSliceInfo.h"

// ----------------------------------------------------------------------------
//
//   GTLQPXExpressTripOption
//

@implementation GTLQPXExpressTripOption
@dynamic identifier, kind, pricing, saleTotal, slice;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"id"
                                forKey:@"identifier"];
  return map;
}

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObjectsAndKeys:
      [GTLQPXExpressPricingInfo class], @"pricing",
      [GTLQPXExpressSliceInfo class], @"slice",
      nil];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"qpxexpress#tripOption"];
}

@end
