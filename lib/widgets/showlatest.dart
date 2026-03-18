import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/widgets/latestcard.dart';
import 'package:rivamiru/widgets/texts.dart';

class ShowLatest extends StatelessWidget {
  final List<Anime> _animeList;
  const ShowLatest(this._animeList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,

          children: [
            TitleSmall(data: "Latest Released"),
            GridView.count(
              shrinkWrap: true,
              childAspectRatio: 0.6,
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: _animeList.map((anime) {
                return LatestCard(anime);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
