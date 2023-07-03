import 'package:giphy_test_task/giphy_api_client.dart';
import 'package:giphy_test_task/giphy_repository.dart';
import 'package:giphy_test_task/giphy_response.dart';

class NetworkGiphyRepository implements GiphyRepository {
  final GiphyApiClient _giphyApiClient;

  NetworkGiphyRepository(this._giphyApiClient);

  @override
  Future<List<GiphyResponse>> getGifs(search) async {
    final gifs = await _giphyApiClient.getGifs(search);
    return gifs;
  }
}
