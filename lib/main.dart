import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_test_task/data/giphy_api_client.dart';
import 'package:giphy_test_task/data/network_giphy_repository.dart';
import 'package:giphy_test_task/domain/giphy_repository.dart';
import 'package:giphy_test_task/presentation/giphy_page.dart';
import 'package:giphy_test_task/presentation/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.giphy.com/v1/gifs/",
    ),
  );
  final giphyApiClient = GiphyApiClient(dio);
  final networkGiphyRepository = NetworkGiphyRepository(giphyApiClient);
  final giphyRepositoryProvider = RepositoryProvider<GiphyRepository>(
    create: (context) => networkGiphyRepository,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        giphyRepositoryProvider,
      ],
      child: const MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}
