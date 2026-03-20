import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/models/database.dart';
import 'package:rivamiru/widgets/sourcesheet.dart';

class PlayButtons extends StatefulWidget {
  final Anime _anime;
  final List<Episode>? _episodes;

  const PlayButtons({
    required Anime anime,
    required List<Episode>? episodes,
    super.key,
  }) : _anime = anime,
       _episodes = episodes;

  @override
  State<StatefulWidget> createState() => _PlayButtonsState();
}

class _PlayButtonsState extends State<PlayButtons> {
  bool isAnimeFavourite = false;

  @override
  void initState() {
    super.initState();
    setAnimeFavourite(widget._anime.id);
  }

  Future<void> setAnimeFavourite(int id) async {
    final isFavourite = await AnimeDatabase().isAnimePresent(id);

    setState(() {
      isAnimeFavourite = isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    void showBottomSheet(Episode e) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SourceSheet(episode: e);
        },
      );
    }

    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: FilledButton(
            onPressed: () {
              setState(() {
                isAnimeFavourite = !(isAnimeFavourite);
              });

              if (isAnimeFavourite) {
                AnimeDatabase().addAnime(widget._anime);
              } else {
                AnimeDatabase().deleteAnime(widget._anime);
              }
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: .center,
              children: [
                isAnimeFavourite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_outline),
                Text("Add"),
              ],
            ),
          ),
        ),

        Expanded(
          child: FilledButton(
            onPressed: () => widget._episodes != null
                ? showBottomSheet(widget._episodes![0])
                : "",
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: .center,
              children: [Icon(Icons.play_arrow), Text("Start")],
            ),
          ),
        ),

        Expanded(
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: .center,
              children: [Icon(Icons.restart_alt), Text("Resume")],
            ),
          ),
        ),
      ],
    );
  }
}
