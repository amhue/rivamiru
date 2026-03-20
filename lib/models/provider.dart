import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:http/http.dart' as http;
import 'package:rivamiru/utils.dart';
import 'package:video_player/video_player.dart';

class Provider extends AnimeInterface {
  static final Provider _instance = Provider._init();

  factory Provider() {
    return _instance;
  }

  Provider._init();

  final _baseUrl = "https://9animetv.to";

  @override
  Future<List<Anime>?> getLatest() async {
    final page = await http.get(Uri.parse("$_baseUrl/home"));

    if (page.statusCode > 299) return null;

    var doc = parse(page.body);
    var items = doc.querySelectorAll('.flw-item');

    return getFromPage(items);
  }

  @override
  Future<List<Anime>?> getPopular() async {
    // TODO: implement getPopular
    throw UnimplementedError();
  }

  @override
  Future<List<Anime>?> searchAnime(String searchTerm) async {
    final page = await http.get(
      Uri.parse("$_baseUrl/search?keyword=$searchTerm"),
    );

    if (page.statusCode > 299) return null;

    var doc = parse(page.body);
    var items = doc.querySelectorAll('.flw-item');

    return getFromPage(items);
  }

  Future<List<Anime>?> getFromPage(List<Element> items) {
    final futures = items.map((e) async {
      String name = e.querySelector('.film-name a')?.text.toString() ?? "";

      return Anime(
        id: int.parse(
          getLastNumber(
                e.querySelector('a.dynamic-name')?.attributes['href'] ?? "",
              ) ??
              "0",
        ),

        name: name,

        imageUrl: e.querySelector('img')?.attributes['data-src'],

        episodes: null,

        description: "Loading description...",

        releaseStatus: ReleaseStatus.loading,
      );
    });

    return Future.wait(futures);
  }

  @override
  Future<List<Episode>?> getEpisodes(Anime anime) async {
    final res = await http.get(
      Uri.parse("$_baseUrl/ajax/episode/list/${anime.id}"),
    );

    if (res.statusCode > 299) return null;

    final json = jsonDecode(res.body);

    if (json['html'] == null) return null;

    final doc = parse(json['html']);
    final episodes = doc.querySelectorAll('.item.ep-item');

    return episodes.map((e) {
      return Episode(
        number: int.parse(e.attributes['data-number']!),
        episodeId: e.attributes['data-id']!,
        animeId: anime.id,
        animeName: anime.name,
        videos: null,
      );
    }).toList();
  }

  @override
  Future<List<Video?>?> getVideos(Episode episode) async {
    final res = await http.get(
      Uri.parse(
        "$_baseUrl/ajax/episode/servers?episodeId=${episode.episodeId}",
      ),
    );

    if (res.statusCode > 299) return null;

    final json = jsonDecode(res.body);

    if (json['html'] == null) return null;

    final doc = parse(json['html']);
    final sources = doc.querySelectorAll('.item.server-item');

    final videos = sources.map((e) async {
      final streamUrl = await getHlsStream(e.attributes['data-id']!);
      if (streamUrl == null) return null;

      final subList = await Future.wait(
        streamUrl.$2!.map(
          (e) async => (await getSubs(e['file']), e['label'] as String),
        ),
      );

      return Video(
        videoName:
            "${e.attributes['data-type']!.toUpperCase()} ${e.text.trim()}",
        episodeNumber: episode.number,
        streamUrl: streamUrl.$1!,
        subtilesList: subList,
      );
    }).toList();

    return Future.wait(videos);
  }

  Future<(String?, List?)?> getHlsStream(String videoId) async {
    final res = await http.get(
      Uri.parse("$_baseUrl/ajax/episode/sources?id=$videoId"),
    );

    if (res.statusCode > 299) return null;

    final rapidCloud = jsonDecode(res.body);
    if (rapidCloud['link'] == null) return null;

    final rapidCloudId = Uri.parse(rapidCloud['link']).pathSegments.last;

    final rapidCloudRes = await http.get(
      Uri.parse(
        "https://rapid-cloud.co/embed-2/v2/e-1/getSources?id=$rapidCloudId",
      ),
    );

    if (rapidCloudRes.statusCode > 299) return null;

    final hlsJson = jsonDecode(rapidCloudRes.body);

    if (hlsJson['sources'] == null || hlsJson['sources'] is! List) {
      return null;
    }

    return (
      hlsJson['sources'][0]['file'] as String,
      hlsJson['tracks'] as List?,
    );
  }

  Future<Subtitles> getSubs(String subUrl) async {
    final res = await http.get(Uri.parse(subUrl));

    if (res.statusCode > 299) return Subtitles([]);

    final subFile = res.body;
    final captions = WebVTTCaptionFile(subFile).captions;
    return Subtitles(
      captions.map((caption) {
        return Subtitle(
          index: caption.number,
          start: caption.start,
          end: caption.end,
          text: caption.text,
        );
      }).toList(),
    );
  }
}
