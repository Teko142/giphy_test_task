import 'package:giphy_test_task/data/giphy_api_client.dart';
import 'package:giphy_test_task/data/giphy_response.dart';
import 'package:giphy_test_task/domain/giphy_repository.dart';

class NetworkGiphyRepository implements GiphyRepository {
  final GiphyApiClient _giphyApiClient;
  final List<GiphyResponse> _faveGifs = [];

  NetworkGiphyRepository(this._giphyApiClient);

  @override
  Future<List<GiphyResponse>> getGifs(search, offset) async {
    final gifs = await _giphyApiClient.getGifs(search, offset);
    return gifs;
  }

  @override
  Future<void> addToFavorite(GiphyResponse gif) async {
    _faveGifs.add(gif);
  }

  @override
  Future<List<GiphyResponse>> getFavorites() async {
    return _faveGifs;
  }

  @override
  Future<void> deleteFromFavorite(GiphyResponse gif) async {
    _faveGifs.remove(gif);
  }
}

