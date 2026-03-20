import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:rivamiru/widgets/texts.dart';

void showLanguageSheet(
  int selected,
  BuildContext context,
  List<(Subtitles, String)> subList,
  Function(int) onSelected,
) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,

          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,

            children: subList
                .asMap()
                .entries
                .map(
                  (e) => ListTile(
                    title: BodyText(data: e.value.$2),
                    dense: true,
                    contentPadding: EdgeInsets.all(0),

                    onTap: () {
                      onSelected(e.key);
                      Navigator.pop(context, e.key);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      );
    },
  );
}
