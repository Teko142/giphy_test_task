import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'giphy_response.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class GiphyResponse extends Equatable {
  final String id;
  final GiphyImagesResponse images;

  const GiphyResponse({
    required this.id,
    required this.images,
  });

  factory GiphyResponse.fromJson(Map<String, dynamic> json) =>
      _$GiphyResponseFromJson(json);

  @override
  List<Object?> get props => [
        id,
        images,
      ];
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class GiphyImagesResponse extends Equatable {
  final GiphyOriginalResponse original;

  const GiphyImagesResponse({
    required this.original,
  });

  factory GiphyImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$GiphyImagesResponseFromJson(json);

  @override
  List<Object?> get props => [
        original,
      ];
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class GiphyOriginalResponse extends Equatable {
  final String url;

  const GiphyOriginalResponse({
    required this.url,
  });

  factory GiphyOriginalResponse.fromJson(Map<String, dynamic> json) =>
      _$GiphyOriginalResponseFromJson(json);

  @override
  List<Object?> get props => [
        url,
      ];
}
