import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_test_task/data/giphy_response.dart';
import 'package:giphy_test_task/domain/giphy_repository.dart';
import 'package:giphy_test_task/presentation/giphy_page.dart';
import 'package:mockito/mockito.dart';

import 'fake_giphy_repository.dart';

class MockGiphyRepository extends Mock implements GiphyRepository {}

void main() {
  group('GiphyPage', () {
    late GiphyRepository repositoryFake;

    setUp(() {
      repositoryFake = FakeGiphyRepository();
    });

    testWidgets('Loading more GIF images on scroll',
        (WidgetTester tester) async {
      final nextPage = [
        const GiphyResponse(
            id: 'id1',
            images: GiphyImagesResponse(
                original: GiphyOriginalResponse(url: 'url1'))),
        const GiphyResponse(
            id: 'id2',
            images: GiphyImagesResponse(
                original: GiphyOriginalResponse(url: 'url2'))),
      ];

      when(repositoryFake.getGifs("cats", 20))
          .thenAnswer((_) async => nextPage);

      await tester.pumpWidget(
        MaterialApp(
          home: const GiphyPage(),
          builder: (context, _) => RepositoryProvider<GiphyRepository>(
            create: (_) => repositoryFake,
            child: const GiphyPage(),
          ),
        ),
      );

      expect(find.byType(Image), findsNWidgets(2));

      await tester.drag(find.byType(GridView), const Offset(0, -300));
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsNWidgets(4));
    });
  });
}
