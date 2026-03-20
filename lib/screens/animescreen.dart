import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/utils.dart';
import 'package:rivamiru/widgets/animedesc.dart';
import 'package:rivamiru/widgets/animeepisodes.dart';
import 'package:rivamiru/widgets/animeheader.dart';
import 'package:rivamiru/widgets/playbuttons.dart';

class AnimeScreen extends StatefulWidget {
  final Anime _anime;
  const AnimeScreen({required Anime anime, super.key}) : _anime = anime;

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  @override
  void initState() {
    loadMetaData(widget._anime.name);
    super.initState();
  }

  Future<void> loadMetaData(String name) async {
    final desc = await getDescription(name);
    final status = await getStatus(name);

    if (!mounted) return;

    setState(() {
      widget._anime.releaseStatus = status;
      widget._anime.description = desc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget._anime.name), leading: BackButton()),

      body: RefreshIndicator(
        onRefresh: () => loadMetaData(widget._anime.name),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                spacing: 20,

                children: [
                  AnimeHeader(anime: widget._anime),
                  PlayButtons(
                    anime: widget._anime,
                    episodes: widget._anime.episodes,
                  ),
                  AnimeDescription(description: widget._anime.description),
                  AnimeEpisodes(anime: widget._anime),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
