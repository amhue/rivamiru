import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/widgets/sourcesheet.dart';
import 'package:rivamiru/widgets/texts.dart';

class AnimeEpisodes extends StatelessWidget {
  final List<Episode>? _episodes;

  const AnimeEpisodes({required List<Episode>? episodes, super.key}) : _episodes = episodes;

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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        TitleSmall(data: "Episodes"),
        SizedBox(height: 10),
        _episodes == null
            ? CircularProgressIndicator()
            : ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: _episodes.reversed
                    .map(
                      (e) => ListTile(
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        title: BodyText(data: "Episode ${e.number}"),
                        onTap: () {
                          showBottomSheet(e);
                        },
                      ),
                    )
                    .toList(),
              ),
      ],
    );
  }
}
