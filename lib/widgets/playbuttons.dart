import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/widgets/sourcesheet.dart';

class PlayButtons extends StatelessWidget {
  final List<Episode>? _episodes;

  const PlayButtons({required List<Episode>? episodes, super.key})
    : _episodes = episodes;

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
            onPressed: () {},
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: .center,
              children: [Icon(Icons.favorite), Text("Add")],
            ),
          ),
        ),

        Expanded(
          child: FilledButton(
            onPressed: () =>
                _episodes != null ? showBottomSheet(_episodes[0]) : "",
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
