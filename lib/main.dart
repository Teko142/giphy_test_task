import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:giphy_test_task/data/giphy_api_client.dart';
import 'package:giphy_test_task/data/network_giphy_repository.dart';
import 'package:giphy_test_task/domain/giphy_repository.dart';
import 'package:giphy_test_task/presentation/main_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ru'),
        ],
        home: MainPage(),
      ),
    ),
  );
}
