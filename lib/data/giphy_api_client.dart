import 'package:dio/dio.dart';
import 'package:giphy_test_task/data/giphy_response.dart';

class GiphyApiClient {
  final Dio _dio;

  GiphyApiClient(this._dio);

  Future<List<GiphyResponse>> getGifs(String search, int offset) async {
    final response = await _dio.get(
        'search?api_key=4Vb0sQlasZ6ZDE4MlrQkv6G92vWF7Mkh&q=$search&limit=20&offset=$offset');
    final data = (response.data['data']) as List<dynamic>;
    final mapped = data
        .map<GiphyResponse>((item) => GiphyResponse.fromJson(item))
        .toList();
    return mapped;

  }
}
