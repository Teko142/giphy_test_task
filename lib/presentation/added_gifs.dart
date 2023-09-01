import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:giphy_test_task/data/giphy_response.dart';
import 'package:giphy_test_task/domain/giphy_repository.dart';

class AddedGifs extends StatefulWidget {
  final GiphyRepository giphyRepository;

  const AddedGifs({super.key, required this.giphyRepository});

  @override
  State<AddedGifs> createState() => _AddedGifsState();
}

class _AddedGifsState extends State<AddedGifs> {
  Future<List<GiphyResponse>>? gifsFuture;
  late final GiphyRepository giphyRepository;

  @override
  void initState() {
    super.initState();
    giphyRepository = context.read();
    gifsFuture = giphyRepository.getFavorites();
  }

  void refreshFavorites() {
    setState(() {
      gifsFuture = giphyRepository.getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<GiphyResponse>>(
          future: gifsFuture,
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final gifs = snapShot.data ?? [];
            return Column(
              children: [
                if (gifs.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.deletingInfo,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                if (gifs.isEmpty) const Spacer(),
                if (gifs.isEmpty)
                  Text(
                    AppLocalizations.of(context)!.favoritePageInfo,
                    style: TextStyle(color: Colors.grey),
                  ),
                if (gifs.isEmpty) const Spacer(),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await giphyRepository.deleteFromFavorite(gifs[index]);
                          refreshFavorites();
                        },
                        child: Image.network(gifs[index].images.original.url),
                      );
                    },
                    itemCount: gifs.length,
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
