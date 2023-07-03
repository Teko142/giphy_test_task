import 'package:giphy_test_task/giphy_response.dart';

abstract class GiphyRepository {
  Future<List<GiphyResponse>> getGifs(String search);
}
