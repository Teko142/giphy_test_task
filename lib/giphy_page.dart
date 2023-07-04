import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_test_task/giphy_repository.dart';
import 'package:giphy_test_task/giphy_response.dart';

class GiphyPage extends StatefulWidget {
  const GiphyPage({super.key});

  @override
  State<GiphyPage> createState() => _GiphyPageState();
}

class _GiphyPageState extends State<GiphyPage> {
  late final GiphyRepository _giphyRepository;
  late Future<List<GiphyResponse>> _giphyFuture;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debouncer;

  void _debounceSearch() {
    if (_debouncer != null) {
      _debouncer?.cancel();
    }
    _debouncer = Timer(const Duration(seconds: 3), () {
      final query = _searchController.text;
      setState(() {
        _giphyFuture = _giphyRepository.getGifs(query);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _giphyRepository = context.read();
    _giphyFuture = Future.value([]);
    _searchController.addListener(() {
      _debounceSearch();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<GiphyResponse>>(
          future: _giphyFuture,
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final gifs = snapShot.data ?? [];
            return Column(
              children: [
                TextFormField(
                  controller: _searchController,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: gifs.length,
                    itemBuilder: (context, index) {
                      return Image.network(gifs[index].images.original.url);
                    },
                  ),
                  /*ListView.builder(
                    itemCount: gifs.length,
                    itemBuilder: (context, index) {
                      return Image.network(gifs[index].images.original.url);
                    },
                  ),*/
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
