import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_test_task/giphy_api_client.dart';
import 'package:giphy_test_task/giphy_page.dart';
import 'package:giphy_test_task/giphy_repository.dart';
import 'package:giphy_test_task/network_giphy_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.giphy.com/v1/gifs/",
    ),
  );
  dio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
    ),
  );
  final giphyApiClinet = GiphyApiClient(dio);
  final networkGiphyRepository = NetworkGiphyRepository(giphyApiClinet);
  final giphyRepositoryProvider = RepositoryProvider<GiphyRepository>(
    create: (context) => networkGiphyRepository,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        giphyRepositoryProvider,
      ],
      child: MaterialApp(
        home: GiphyPage(),
      ),
    ),
  );
}
