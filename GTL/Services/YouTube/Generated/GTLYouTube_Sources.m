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
//  GTLYouTube_Sources.m
//
// This file can be compiled into projects to avoid adding the individual
// source files for this service.
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   YouTube Data API (youtube/v3)
// Description:
//   Programmatic access to YouTube features.
// Documentation:
//   https://developers.google.com/youtube/v3

#import "GTLYouTubeConstants.m"

#import "GTLYouTubeAccessPolicy.m"
#import "GTLYouTubeActivity.m"
#import "GTLYouTubeActivityContentDetails.m"
#import "GTLYouTubeActivityContentDetailsBulletin.m"
#import "GTLYouTubeActivityContentDetailsChannelItem.m"
#import "GTLYouTubeActivityContentDetailsComment.m"
#import "GTLYouTubeActivityContentDetailsFavorite.m"
#import "GTLYouTubeActivityContentDetailsLike.m"
#import "GTLYouTubeActivityContentDetailsPlaylistItem.m"
#import "GTLYouTubeActivityContentDetailsPromotedItem.m"
#import "GTLYouTubeActivityContentDetailsRecommendation.m"
#import "GTLYouTubeActivityContentDetailsSocial.m"
#import "GTLYouTubeActivityContentDetailsSubscription.m"
#import "GTLYouTubeActivityContentDetailsUpload.m"
#import "GTLYouTubeActivityListResponse.m"
#import "GTLYouTubeActivitySnippet.m"
#import "GTLYouTubeCdnSettings.m"
#import "GTLYouTubeChannel.m"
#import "GTLYouTubeChannelAuditDetails.m"
#import "GTLYouTubeChannelBannerResource.m"
#import "GTLYouTubeChannelBrandingSettings.m"
#import "GTLYouTubeChannelContentDetails.m"
#import "GTLYouTubeChannelContentOwnerDetails.m"
#import "GTLYouTubeChannelConversionPing.m"
#import "GTLYouTubeChannelConversionPings.m"
#import "GTLYouTubeChannelListResponse.m"
#import "GTLYouTubeChannelLocalization.m"
#import "GTLYouTubeChannelSection.m"
#import "GTLYouTubeChannelSectionContentDetails.m"
#import "GTLYouTubeChannelSectionListResponse.m"
#import "GTLYouTubeChannelSectionSnippet.m"
#import "GTLYouTubeChannelSettings.m"
#import "GTLYouTubeChannelSnippet.m"
#import "GTLYouTubeChannelStatistics.m"
#import "GTLYouTubeChannelStatus.m"
#import "GTLYouTubeChannelTopicDetails.m"
#import "GTLYouTubeContentRating.m"
#import "GTLYouTubeGeoPoint.m"
#import "GTLYouTubeGuideCategory.m"
#import "GTLYouTubeGuideCategoryListResponse.m"
#import "GTLYouTubeGuideCategorySnippet.m"
#import "GTLYouTubeI18nLanguage.m"
#import "GTLYouTubeI18nLanguageListResponse.m"
#import "GTLYouTubeI18nLanguageSnippet.m"
#import "GTLYouTubeI18nRegion.m"
#import "GTLYouTubeI18nRegionListResponse.m"
#import "GTLYouTubeI18nRegionSnippet.m"
#import "GTLYouTubeImageSettings.m"
#import "GTLYouTubeIngestionInfo.m"
#import "GTLYouTubeInvideoBranding.m"
#import "GTLYouTubeInvideoPosition.m"
#import "GTLYouTubeInvideoPromotion.m"
#import "GTLYouTubeInvideoTiming.m"
#import "GTLYouTubeLanguageTag.m"
#import "GTLYouTubeLiveBroadcast.m"
#import "GTLYouTubeLiveBroadcastContentDetails.m"
#import "GTLYouTubeLiveBroadcastListResponse.m"
#import "GTLYouTubeLiveBroadcastSnippet.m"
#import "GTLYouTubeLiveBroadcastStatus.m"
#import "GTLYouTubeLiveStream.m"
#import "GTLYouTubeLiveStreamContentDetails.m"
#import "GTLYouTubeLiveStreamListResponse.m"
#import "GTLYouTubeLiveStreamSnippet.m"
#import "GTLYouTubeLiveStreamStatus.m"
#import "GTLYouTubeLocalizedProperty.m"
#import "GTLYouTubeLocalizedString.m"
#import "GTLYouTubeMonitorStreamInfo.m"
#import "GTLYouTubePageInfo.m"
#import "GTLYouTubePlaylist.m"
#import "GTLYouTubePlaylistContentDetails.m"
#import "GTLYouTubePlaylistItem.m"
#import "GTLYouTubePlaylistItemContentDetails.m"
#import "GTLYouTubePlaylistItemListResponse.m"
#import "GTLYouTubePlaylistItemSnippet.m"
#import "GTLYouTubePlaylistItemStatus.m"
#import "GTLYouTubePlaylistListResponse.m"
#import "GTLYouTubePlaylistPlayer.m"
#import "GTLYouTubePlaylistSnippet.m"
#import "GTLYouTubePlaylistStatus.m"
#import "GTLYouTubePromotedItem.m"
#import "GTLYouTubePromotedItemId.m"
#import "GTLYouTubePropertyValue.m"
#import "GTLYouTubeResourceId.m"
#import "GTLYouTubeSearchListResponse.m"
#import "GTLYouTubeSearchResult.m"
#import "GTLYouTubeSearchResultSnippet.m"
#import "GTLYouTubeSubscription.m"
#import "GTLYouTubeSubscriptionContentDetails.m"
#import "GTLYouTubeSubscriptionListResponse.m"
#import "GTLYouTubeSubscriptionSnippet.m"
#import "GTLYouTubeSubscriptionSubscriberSnippet.m"
#import "GTLYouTubeThumbnail.m"
#import "GTLYouTubeThumbnailDetails.m"
#import "GTLYouTubeThumbnailSetResponse.m"
#import "GTLYouTubeTokenPagination.m"
#import "GTLYouTubeVideo.m"
#import "GTLYouTubeVideoAgeGating.m"
#import "GTLYouTubeVideoCategory.m"
#import "GTLYouTubeVideoCategoryListResponse.m"
#import "GTLYouTubeVideoCategorySnippet.m"
#import "GTLYouTubeVideoContentDetails.m"
#import "GTLYouTubeVideoContentDetailsRegionRestriction.m"
#import "GTLYouTubeVideoConversionPing.m"
#import "GTLYouTubeVideoConversionPings.m"
#import "GTLYouTubeVideoFileDetails.m"
#import "GTLYouTubeVideoFileDetailsAudioStream.m"
#import "GTLYouTubeVideoFileDetailsVideoStream.m"
#import "GTLYouTubeVideoGetRatingResponse.m"
#import "GTLYouTubeVideoListResponse.m"
#import "GTLYouTubeVideoLiveStreamingDetails.m"
#import "GTLYouTubeVideoMonetizationDetails.m"
#import "GTLYouTubeVideoPlayer.m"
#import "GTLYouTubeVideoProcessingDetails.m"
#import "GTLYouTubeVideoProcessingDetailsProcessingProgress.m"
#import "GTLYouTubeVideoProjectDetails.m"
#import "GTLYouTubeVideoRating.m"
#import "GTLYouTubeVideoRecordingDetails.m"
#import "GTLYouTubeVideoSnippet.m"
#import "GTLYouTubeVideoStatistics.m"
#import "GTLYouTubeVideoStatus.m"
#import "GTLYouTubeVideoSuggestions.m"
#import "GTLYouTubeVideoSuggestionsTagSuggestion.m"
#import "GTLYouTubeVideoTopicDetails.m"
#import "GTLYouTubeWatchSettings.m"

#import "GTLQueryYouTube.m"
#import "GTLServiceYouTube.m"
