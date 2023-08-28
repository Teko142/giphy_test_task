import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_test_task/data/giphy_response.dart';
import 'package:giphy_test_task/domain/giphy_repository.dart';

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
  int _offset = 0;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  String _query = '';

  void _loadMore() async {
    if (_isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _offset += 20;

      final List<GiphyResponse> newPage =
          await _giphyRepository.getGifs(_query, _offset);
      setState(() {
        _giphyFuture =
            _giphyFuture.then((existingGifs) => existingGifs + newPage);
      });

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    _giphyRepository = context.read();
    _giphyFuture = Future.value([]);
    _searchController.addListener(() {
      _debounceSearch();
    });

    setState(() {
      _isFirstLoadRunning = false;
    });
    // additional value
  }

  void _debounceSearch() {
    if (_debouncer != null) {
      _debouncer?.cancel();
    }
    _debouncer = Timer(const Duration(seconds: 2), () {
      _offset = 0;
      _query = _searchController.text;
      setState(() {
        _giphyFuture = _giphyRepository.getGifs(_query, _offset);
      });
    });
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
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
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Start gifs search...",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                if (gifs.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Click on a gif to add it to your favorites",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    controller: _controller,
                    itemCount: gifs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _giphyRepository.addToFavorite(gifs[index]);
                        },
                        child: Image.network(gifs[index].images.original.url),
                      );
                    },
                  ),
                ),
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
