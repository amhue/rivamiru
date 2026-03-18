import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/widgets/texts.dart';

class AnimeHeader extends StatelessWidget {
  final Anime _anime;

  const AnimeHeader({required Anime anime, super.key}) : _anime = anime;

  @override
  Widget build(BuildContext context) {
    final img = _anime.imageUrl;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        img != null
            ? Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2.5,
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(img, fit: BoxFit.cover),
                ),
              )
            : Expanded(
                child: Icon(
                  Icons.error,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),

        SizedBox(width: 20),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,

            children: [
              TitleSmall(data: _anime.name),
              BodyText(data: "${_anime.episodes?.length ?? 0} episodes released"),
              _anime.releaseStatus == ReleaseStatus.loading
                  ? CircularProgressIndicator()
                  : DescText(
                      data: _anime.releaseStatus == ReleaseStatus.airing
                          ? "Currently Airing"
                          : _anime.releaseStatus == ReleaseStatus.completed
                          ? "Completed Airing"
                          : "Not aired yet",
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
