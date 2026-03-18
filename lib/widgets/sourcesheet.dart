import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/screens/searchscreen.dart';
import 'package:rivamiru/widgets/texts.dart';

class SourceSheet extends StatefulWidget {
  final Episode _episode;

  const SourceSheet({required Episode episode, super.key}) : _episode = episode;

  @override
  State<StatefulWidget> createState() => _SourceSheetState();
}

class _SourceSheetState extends State<SourceSheet> {
  @override
  void initState() {
    super.initState();
    loadVideos(widget._episode);
  }

  Future<void> loadVideos(Episode e) async {
    if (e.videos == null) {
      final videos = await provider.getVideos(e);
      setState(() {
        e.videos = videos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 10,

          children: [
            TitleSmall(data: "Select source"),
            Divider(),

            ...(widget._episode.videos != null
                ? widget._episode.videos!
                      .map(
                        (video) => video != null
                            ? ListTile(
                                title: BodyText(data: video.videoName),
                                dense: true,
                                contentPadding: EdgeInsets.all(0),

                                onTap: () {
                                  context.push("/video", extra: video);
                                },
                              )
                            : Container(),
                      )
                      .toList()
                : [CircularProgressIndicator()]),
          ],
        ),
      ),
    );
  }
}
