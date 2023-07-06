import 'package:giphy_test_task/data/giphy_api_client.dart';
import 'package:giphy_test_task/data/giphy_response.dart';
import 'package:giphy_test_task/domain/giphy_repository.dart';

class NetworkGiphyRepository implements GiphyRepository {
  final GiphyApiClient _giphyApiClient;

  NetworkGiphyRepository(this._giphyApiClient);

  @override
  Future<List<GiphyResponse>> getGifs(search, offset) async {
    final gifs = await _giphyApiClient.getGifs(search, offset);
    return gifs;
  }
}
