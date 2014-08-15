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
//  GTLMapsEngineConstants.m
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

#import "GTLMapsEngineConstants.h"

// Authorization scope
NSString * const kGTLAuthScopeMapsEngine         = @"https://www.googleapis.com/auth/mapsengine";
NSString * const kGTLAuthScopeMapsEngineReadonly = @"https://www.googleapis.com/auth/mapsengine.readonly";

// GTLMapsEngineAcquisitionTime - Precision
NSString * const kGTLMapsEngineAcquisitionTime_Precision_Day   = @"day";
NSString * const kGTLMapsEngineAcquisitionTime_Precision_Hour  = @"hour";
NSString * const kGTLMapsEngineAcquisitionTime_Precision_Minute = @"minute";
NSString * const kGTLMapsEngineAcquisitionTime_Precision_Month = @"month";
NSString * const kGTLMapsEngineAcquisitionTime_Precision_Second = @"second";
NSString * const kGTLMapsEngineAcquisitionTime_Precision_Year  = @"year";

// GTLMapsEngineAsset - Type
NSString * const kGTLMapsEngineAsset_Type_Layer            = @"layer";
NSString * const kGTLMapsEngineAsset_Type_Map              = @"map";
NSString * const kGTLMapsEngineAsset_Type_Raster           = @"raster";
NSString * const kGTLMapsEngineAsset_Type_RasterCollection = @"rasterCollection";
NSString * const kGTLMapsEngineAsset_Type_Table            = @"table";

// GTLMapsEngineFile - UploadStatus
NSString * const kGTLMapsEngineFile_UploadStatus_Canceled   = @"canceled";
NSString * const kGTLMapsEngineFile_UploadStatus_Complete   = @"complete";
NSString * const kGTLMapsEngineFile_UploadStatus_Failed     = @"failed";
NSString * const kGTLMapsEngineFile_UploadStatus_InProgress = @"inProgress";

// GTLMapsEngineFilter - OperatorProperty
NSString * const kGTLMapsEngineFilter_OperatorProperty_Contains = @"contains";
NSString * const kGTLMapsEngineFilter_OperatorProperty_EndsWith = @"endsWith";
NSString * const kGTLMapsEngineFilter_OperatorProperty_StartsWith = @"startsWith";
NSString * const kGTLMapsEngineFilter_OperatorProperty_X       = @">=";

// GTLMapsEngineGeoJsonGeometryCollection - Type
NSString * const kGTLMapsEngineGeoJsonGeometryCollection_Type_GeometryCollection = @"GeometryCollection";

// GTLMapsEngineGeoJsonLineString - Type
NSString * const kGTLMapsEngineGeoJsonLineString_Type_LineString = @"LineString";

// GTLMapsEngineGeoJsonMultiLineString - Type
NSString * const kGTLMapsEngineGeoJsonMultiLineString_Type_MultiLineString = @"MultiLineString";

// GTLMapsEngineGeoJsonMultiPoint - Type
NSString * const kGTLMapsEngineGeoJsonMultiPoint_Type_MultiPoint = @"MultiPoint";

// GTLMapsEngineGeoJsonMultiPolygon - Type
NSString * const kGTLMapsEngineGeoJsonMultiPolygon_Type_MultiPolygon = @"MultiPolygon";

// GTLMapsEngineGeoJsonPoint - Type
NSString * const kGTLMapsEngineGeoJsonPoint_Type_Point = @"Point";

// GTLMapsEngineGeoJsonPolygon - Type
NSString * const kGTLMapsEngineGeoJsonPolygon_Type_Polygon = @"Polygon";

// GTLMapsEngineLabelStyle - FontStyle
NSString * const kGTLMapsEngineLabelStyle_FontStyle_Italic = @"italic";
NSString * const kGTLMapsEngineLabelStyle_FontStyle_Normal = @"normal";

// GTLMapsEngineLabelStyle - FontWeight
NSString * const kGTLMapsEngineLabelStyle_FontWeight_Bold   = @"bold";
NSString * const kGTLMapsEngineLabelStyle_FontWeight_Normal = @"normal";

// GTLMapsEngineLayer - DatasourceType
NSString * const kGTLMapsEngineLayer_DatasourceType_Image = @"image";
NSString * const kGTLMapsEngineLayer_DatasourceType_Table = @"table";

// GTLMapsEngineLayer - ProcessingStatus
NSString * const kGTLMapsEngineLayer_ProcessingStatus_Complete = @"complete";
NSString * const kGTLMapsEngineLayer_ProcessingStatus_Failed   = @"failed";
NSString * const kGTLMapsEngineLayer_ProcessingStatus_NotReady = @"notReady";
NSString * const kGTLMapsEngineLayer_ProcessingStatus_Processing = @"processing";
NSString * const kGTLMapsEngineLayer_ProcessingStatus_Ready    = @"ready";

// GTLMapsEngineMap - Versions
NSString * const kGTLMapsEngineMap_Versions_Draft     = @"draft";
NSString * const kGTLMapsEngineMap_Versions_Published = @"published";

// GTLMapsEngineMapFolder - Type
NSString * const kGTLMapsEngineMapFolder_Type_Folder = @"folder";

// GTLMapsEngineMapKmlLink - Type
NSString * const kGTLMapsEngineMapKmlLink_Type_KmlLink = @"kmlLink";

// GTLMapsEngineMapLayer - Type
NSString * const kGTLMapsEngineMapLayer_Type_Layer = @"layer";

// GTLMapsEngineRaster - MaskType
NSString * const kGTLMapsEngineRaster_MaskType_AlphaChannelMask = @"alphaChannelMask";
NSString * const kGTLMapsEngineRaster_MaskType_AutoMask        = @"autoMask";
NSString * const kGTLMapsEngineRaster_MaskType_ImageMask       = @"imageMask";
NSString * const kGTLMapsEngineRaster_MaskType_NoMask          = @"noMask";

// GTLMapsEngineRaster - ProcessingStatus
NSString * const kGTLMapsEngineRaster_ProcessingStatus_Complete = @"complete";
NSString * const kGTLMapsEngineRaster_ProcessingStatus_Failed  = @"failed";
NSString * const kGTLMapsEngineRaster_ProcessingStatus_NotReady = @"notReady";
NSString * const kGTLMapsEngineRaster_ProcessingStatus_Processing = @"processing";
NSString * const kGTLMapsEngineRaster_ProcessingStatus_Ready   = @"ready";

// GTLMapsEngineRaster - RasterType
NSString * const kGTLMapsEngineRaster_RasterType_Image = @"image";

// GTLMapsEngineRasterCollection - ProcessingStatus
NSString * const kGTLMapsEngineRasterCollection_ProcessingStatus_Complete = @"complete";
NSString * const kGTLMapsEngineRasterCollection_ProcessingStatus_Failed = @"failed";
NSString * const kGTLMapsEngineRasterCollection_ProcessingStatus_NotReady = @"notReady";
NSString * const kGTLMapsEngineRasterCollection_ProcessingStatus_Processing = @"processing";
NSString * const kGTLMapsEngineRasterCollection_ProcessingStatus_Ready = @"ready";

// GTLMapsEngineRasterCollection - RasterType
NSString * const kGTLMapsEngineRasterCollection_RasterType_Image = @"image";

// GTLMapsEngineTable - ProcessingStatus
NSString * const kGTLMapsEngineTable_ProcessingStatus_Complete = @"complete";
NSString * const kGTLMapsEngineTable_ProcessingStatus_Failed   = @"failed";
NSString * const kGTLMapsEngineTable_ProcessingStatus_NotReady = @"notReady";
NSString * const kGTLMapsEngineTable_ProcessingStatus_Processing = @"processing";
NSString * const kGTLMapsEngineTable_ProcessingStatus_Ready    = @"ready";

// GTLMapsEngineTableColumn - Type
NSString * const kGTLMapsEngineTableColumn_Type_Boolean       = @"boolean";
NSString * const kGTLMapsEngineTableColumn_Type_Datetime      = @"datetime";
NSString * const kGTLMapsEngineTableColumn_Type_Double        = @"double";
NSString * const kGTLMapsEngineTableColumn_Type_Integer       = @"integer";
NSString * const kGTLMapsEngineTableColumn_Type_LineStrings   = @"lineStrings";
NSString * const kGTLMapsEngineTableColumn_Type_MixedGeometry = @"mixedGeometry";
NSString * const kGTLMapsEngineTableColumn_Type_Points        = @"points";
NSString * const kGTLMapsEngineTableColumn_Type_Polygons      = @"polygons";
NSString * const kGTLMapsEngineTableColumn_Type_String        = @"string";

// GTLMapsEngineVectorStyle - Type
NSString * const kGTLMapsEngineVectorStyle_Type_DisplayRule = @"displayRule";

// GTLQueryMapsEngine - Type
NSString * const kGTLMapsEngineTypeLayer            = @"layer";
NSString * const kGTLMapsEngineTypeMap              = @"map";
NSString * const kGTLMapsEngineTypeRasterCollection = @"rasterCollection";
NSString * const kGTLMapsEngineTypeTable            = @"table";

// GTLQueryMapsEngine - Version
NSString * const kGTLMapsEngineVersionDraft     = @"draft";
NSString * const kGTLMapsEngineVersionPublished = @"published";
