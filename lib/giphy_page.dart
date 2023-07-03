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
  late final Future<List<GiphyResponse>> _giphyFuture;

  @override
  void initState() {
    super.initState();
    _giphyRepository = context.read();
    _giphyFuture = _giphyRepository.getGifs();
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
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Image.network(gifs[index].images.original.url);
                    },
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
