import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rivamiru/models/animeinterface.dart';

class LatestCard extends StatelessWidget {
  final Anime _anime;

  const LatestCard(this._anime, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push("/watch", extra: _anime),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              _anime.imageUrl ?? "",
              fit: BoxFit.cover,
              height: 300,
              // width: double.infinity,
            ),
          ),
          Container(
            alignment: .bottomStart,
            padding: EdgeInsets.all(5),
            child: Text(
              _anime.name,
              maxLines: 2,
              style: TextStyle(
                fontWeight: .w500,
                fontSize: 12,
                shadows: [
                  Shadow(
                    color: Theme.of(context).colorScheme.onPrimary,
                    blurRadius: 2,
                  ),
                  Shadow(
                    color: Theme.of(context).colorScheme.onSecondary,
                    blurRadius: 2,
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
