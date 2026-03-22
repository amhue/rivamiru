import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:chewie/chewie.dart';
import 'package:rivamiru/widgets/selectsubsheet.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class VideoScreen extends StatefulWidget {
  final Video _video;

  const VideoScreen({required Video video, super.key}) : _video = video;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;
  int subTitleLanguageIndex = 0;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initPlayer();

    WakelockPlus.enable();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    WakelockPlus.disable();

    super.dispose();
  }

  Future<void> initPlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget._video.streamUrl),
    );

    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      allowFullScreen: true,
      allowedScreenSleep: false,
      autoPlay: true,
      showControls: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      zoomAndPan: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      subtitle: widget._video.subtilesList[subTitleLanguageIndex].$1,
      showSubtitles: widget._video.subtilesList.isNotEmpty,
      subtitleBuilder: (context, subtitle) {
        return Center(
          child: Text(
            subtitle as String,
            textAlign: .center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              shadows: [
                Shadow(color: Colors.black, offset: Offset(1, 1)),
                Shadow(color: Colors.black, offset: Offset(-1, 1)),
                Shadow(color: Colors.black, offset: Offset(-1, -1)),
                Shadow(color: Colors.black, offset: Offset(1, -1)),
              ],
            ),
          ),
        );
      },
      additionalOptions: (context) => [
        OptionItem(
          onTap: (context) => showLanguageSheet(
            subTitleLanguageIndex,
            context,
            widget._video.subtilesList,
            (selected) {
              setState(() {
                subTitleLanguageIndex = selected;
                _chewieController!.setSubtitle(
                  widget._video.subtilesList[subTitleLanguageIndex].$1.subtitle
                      .whereType<Subtitle>()
                      .toList(),
                );
              });
            },
          ),
          iconData: Icons.closed_caption,
          title: "Subtitle Language",
        ),
      ],
      // sub
      // customControls: AppBar(
      // leading: BackButton(),
      // title: TitleSmall(data: widget._video.videoName),
      // ),
      // subtitle: S
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Center(
          child:
              _chewieController != null &&
                  _chewieController!.videoPlayerController.value.isInitialized
              ? Chewie(controller: _chewieController!)
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
