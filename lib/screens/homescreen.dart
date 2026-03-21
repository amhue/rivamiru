import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/models/database.dart';
import 'package:rivamiru/widgets/showlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

late final SharedPreferences prefs;

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
            animeList.isNotEmpty
                ? Container(
                    padding: EdgeInsets.all(10),
                    child: ShowList(animeList),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .center,
                      children: [
                        Text(
                          "No Anime in Library",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: .w400,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          "(ᗒ︵ᗕ)՞",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: .w400,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
