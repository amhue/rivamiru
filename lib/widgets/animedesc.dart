import 'package:flutter/material.dart';
import 'package:rivamiru/widgets/texts.dart';

class AnimeDescription extends StatefulWidget {
  final String? _description;

  const AnimeDescription({String? description, super.key})
    : _description = description;

  @override
  State<AnimeDescription> createState() => _AnimeDescriptionState();
}

class _AnimeDescriptionState extends State<AnimeDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget._description == null) return CircularProgressIndicator();

    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !(isExpanded);
        });
      },

      child: isExpanded
          ? BodyText(data: widget._description!)
          : Text(
              widget._description!,
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
    );
  }
}
