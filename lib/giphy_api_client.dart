import 'package:dio/dio.dart';
import 'package:giphy_test_task/giphy_response.dart';

class GiphyApiClient {

  final Dio _dio;

  GiphyApiClient(this._dio);

  Future<List<GiphyResponse>> getBooks() async {
    final response = await _dio.get('search?api_key=4Vb0sQlasZ6ZDE4MlrQkv6G92vWF7Mkh&q=a');
    final data = (response.data['data']) as List<dynamic>;
    print("Api: $data");
    final mapped = data
        .map<GiphyResponse>((item) => GiphyResponse.fromJson(item))
        .toList();
    print("Api 2: $mapped");
    return mapped;
  }


}