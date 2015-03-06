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
//  GTLMapsEngineIconStyle.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Google Maps Engine API (mapsengine/v1)
// Description:
//   The Google Maps Engine API allows developers to store and query geospatial
//   vector and raster data.
// Documentation:
//   https://developers.google.com/maps-engine/
// Classes:
//   GTLMapsEngineIconStyle (0 custom class methods, 4 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLMapsEngineScaledShape;
@class GTLMapsEngineScalingFunction;

// ----------------------------------------------------------------------------
//
//   GTLMapsEngineIconStyle
//

// Style for icon, this is part of point style.

@interface GTLMapsEngineIconStyle : GTLObject

// Custom icon id.
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (copy) NSString *identifier;

// Stock icon name. To use a stock icon, prefix it with 'gx_'. See Stock icon
// names for valid icon names. For example, to specify small_red, set name to
// 'gx_small_red'.
@property (copy) NSString *name;

// A scalable shape.
@property (retain) GTLMapsEngineScaledShape *scaledShape;

// The function used to scale shapes. Required when a scaledShape is specified.
@property (retain) GTLMapsEngineScalingFunction *scalingFunction;

@end
