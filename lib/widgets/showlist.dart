import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/widgets/animecard.dart';

class ShowList extends StatelessWidget {
  final List<Anime> _animeList;
  const ShowList(this._animeList, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: 0.6,
      crossAxisCount: 3,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: _animeList.map((anime) {
        return AnimeCard(anime);
      }).toList(),
    );
  }
}
