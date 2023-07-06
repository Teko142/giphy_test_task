// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'giphy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiphyResponse _$GiphyResponseFromJson(Map<String, dynamic> json) =>
    GiphyResponse(
      id: json['id'] as String,
      images:
          GiphyImagesResponse.fromJson(json['images'] as Map<String, dynamic>),
    );

GiphyImagesResponse _$GiphyImagesResponseFromJson(Map<String, dynamic> json) =>
    GiphyImagesResponse(
      original: GiphyOriginalResponse.fromJson(
          json['original'] as Map<String, dynamic>),
    );

GiphyOriginalResponse _$GiphyOriginalResponseFromJson(
        Map<String, dynamic> json) =>
    GiphyOriginalResponse(
      url: json['url'] as String,
    );
