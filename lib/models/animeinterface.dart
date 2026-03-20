import 'package:chewie/chewie.dart';

enum ReleaseStatus { airing, completed, loading }

class Anime {
  int id;
  String name;
  String? description;
  List<Episode>? episodes;
  String? imageUrl;
  ReleaseStatus? releaseStatus;

  Anime({
    required this.id,
    required this.name,
    this.description,
    this.episodes,
    this.imageUrl,
    this.releaseStatus,
  });

  Anime.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      name = map['name'],
      description = map['description'],
      imageUrl = map['imageUrl'];

  // Implementing only anime metadata to be stored in db
  Map<String, dynamic> map() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}

class Episode {
  int number;
  String episodeId;
  int animeId;
  String animeName;
  List<Video?>? videos;

  Episode({
    required this.number,
    required this.episodeId,
    required this.animeId,
    required this.animeName,
    required this.videos,
  });
}

class Video {
  final String videoName;
  final int episodeNumber;
  final String streamUrl;
  final List<(Subtitles, String)> subtilesList;

  const Video({
    required this.videoName,
    required this.episodeNumber,
    required this.streamUrl,
    required this.subtilesList,
  });
}

abstract class AnimeInterface {
  Future<List<Anime>?> getLatest();
  Future<List<Anime>?> getPopular();
  Future<List<Anime>?> searchAnime(String searchTerm);
  Future<List<Episode>?> getEpisodes(Anime anime);
  Future<List<Video?>?> getVideos(Episode episode);
}
