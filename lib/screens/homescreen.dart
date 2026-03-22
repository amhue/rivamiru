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
  bool isSearchPressed = false;
  String searchText = "";
  final TextEditingController textEditingController = TextEditingController();
  List<Anime> toShow = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favorites = await AnimeDatabase().getAllAnime();

    setState(() {
      animeList = favorites;
      toShow = animeList
          .where(
            (e) =>
                e.name.split(' ').join().contains(searchText.split(' ').join()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearchPressed
            ? Text("Anime")
            : TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: InputDecoration(hintText: "Search library"),
                onTapOutside: (_) {
                  if (searchText.isEmpty) {
                    setState(() {
                      isSearchPressed = !isSearchPressed;
                    });
                  }
                },
                onChanged: (text) {
                  setState(() {
                    searchText = text;

                    toShow = animeList
                        .where(
                          (e) => e.name
                              .toLowerCase()
                              .replaceAll(' ', '')
                              .contains(
                                searchText.toLowerCase().replaceAll(' ', ''),
                              ),
                        )
                        .toList();
                  });
                },
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchPressed = !isSearchPressed;
              });
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: loadFavorites,
        child: ListView(
          children: [
            toShow.isNotEmpty
                ? Container(
                    padding: EdgeInsets.all(10),
                    child: ShowList(toShow),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .center,
                      children: [
                        Text(
                          searchText.isEmpty ? 
                          "No Anime in Library" : "$searchText not found",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: .w400,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          searchText.isEmpty ? 
                          "(ᗒ︵ᗕ)՞" : "(ó д ò)",
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
