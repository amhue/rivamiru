import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rivamiru/models/animeinterface.dart';

String slugify(String input) {
  return input
      .replaceAll(RegExp(r'\s+'), '-')
      .replaceAll(RegExp(r'[^a-zA-Z0-9-]'), '')
      .replaceAll(RegExp(r'-+'), '-')
      .replaceAll(RegExp(r'^-|-$'), '');
}

String? getLastNumber(String input) {
  final matches = RegExp(r'\d+').allMatches(input);
  return matches.isNotEmpty ? matches.last.group(0) : null;
}

Future<String> getDescription(String name) async {
  final url = Uri.https("api.jikan.moe", "/v4/anime", {"q": name});
  final res = await http.get(url);

  if (res.statusCode <= 299) {
    final data = jsonDecode(res.body);
    String desc = "";

    if (data['data'] != null &&
        data['data'] is List &&
        data['data'].isNotEmpty) {
      desc = data['data'][0]['synopsis'];
    }

    return desc;
  }

  return "";
}

Future<ReleaseStatus?> getStatus(String name) async {
  final url = Uri.parse("https://api.jikan.moe/v4/anime?q=$name");
  final res = await http.get(url);

  if (res.statusCode <= 299) {
    final data = jsonDecode(res.body);
    if (data['data'] != null &&
        data['data'] is List &&
        data['data'].isNotEmpty) {
      String status = data['data'][0]['status'];

      return status.contains("Finished")
          ? ReleaseStatus.completed
          : status.contains("Currently")
          ? ReleaseStatus.airing
          : null;
    }
  }

  return null;
}
