import 'package:giphy_test_task/data/giphy_response.dart';

abstract class GiphyRepository {
  Future<List<GiphyResponse>> getGifs(String search, int offset);

  Future<void> addToFavorite(GiphyResponse gif);

  Future<List<GiphyResponse>> getFavorites();

  Future<void> deleteFromFavorite(GiphyResponse gif);
}
