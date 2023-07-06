import 'package:giphy_test_task/data/giphy_response.dart';

abstract class GiphyRepository {
  Future<List<GiphyResponse>> getGifs(String search, int offset);
}
