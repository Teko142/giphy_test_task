import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:giphy_test_task/data/giphy_response.dart';
import 'package:giphy_test_task/domain/giphy_repository.dart';
import 'package:giphy_test_task/presentation/added_gifs.dart';
import 'package:giphy_test_task/presentation/giphy_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final GiphyRepository _giphyRepository;
  Future<List<GiphyResponse>>? gifsFuture;

  @override
  void initState() {
    super.initState();
    _giphyRepository = context.read();
    gifsFuture = _giphyRepository.getFavorites();
  }

  var _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedTabIndex,
        children: [
          const GiphyPage(),
          AddedGifs(
            giphyRepository: _giphyRepository,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: AppLocalizations.of(context)!.searchIconText),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: AppLocalizations.of(context)!.favoriteIconText,
          ),
        ],
      ),
    );
  }
}
