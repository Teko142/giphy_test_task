import 'package:giphy_test_task/data/giphy_response.dart';
import 'package:giphy_test_task/domain/giphy_repository.dart';
import 'package:mockito/mockito.dart';

const fakeGif = GiphyResponse(
    id: 'id1',
    images: GiphyImagesResponse(original: GiphyOriginalResponse(url: 'url1')));

class FakeGiphyRepository extends Mock implements GiphyRepository {
  @override
  Future<List<GiphyResponse>> getGifs(String search, int offset) async {
    return [
      const GiphyResponse(
          id: 'id1',
          images:
              GiphyImagesResponse(original: GiphyOriginalResponse(url: 'url1')))
    ];
  }
}
