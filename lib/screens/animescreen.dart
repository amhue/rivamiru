import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/models/provider.dart';
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
  List<Episode>? _episodes;
  bool isSearchPressed = false;
  final TextEditingController textEditingController = TextEditingController();
  String searchText = "";
  List<Episode>? toShow;

  @override
  void initState() {
    super.initState();
    loadMetaData(widget._anime.name);
    loadEpisodes(widget._anime);
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

  Future<void> loadEpisodes(Anime anime) async {
    final episodes = await Provider().getEpisodes(anime);
    widget._anime.episodes = episodes;
    setState(() {
      _episodes = episodes;
      toShow = _episodes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearchPressed
            ? Text(widget._anime.name)
            : TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: InputDecoration(hintText: "Search Episode"),
                onTapOutside: (_) {
                  if (searchText.isEmpty) {
                    setState(() {
                      isSearchPressed = !isSearchPressed;
                    });
                  }
                },
                onChanged: (text) {
                  setState(() {
                    searchText = text;

                    toShow = _episodes
                        ?.where(
                          (e) => "episode${e.number.toString().toLowerCase()}"
                              .contains(
                                searchText.toLowerCase().replaceAll(' ', ''),
                              ),
                        )
                        .toList();
                  });
                },
              ),

        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchPressed = !isSearchPressed;
              });
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),

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
                  AnimeEpisodes(episodes: toShow),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
