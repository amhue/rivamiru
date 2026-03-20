import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/models/database.dart';
import 'package:rivamiru/widgets/showlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Anime> animeList = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favorites = await AnimeDatabase().getAllAnime();

    setState(() {
      animeList = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Anime")),
      body: RefreshIndicator(
        onRefresh: loadFavorites,
        child: ListView(
          children: [
            Container(padding: EdgeInsets.all(10), child: ShowList(animeList)),
          ],
        ),
      ),
    );
  }
}
