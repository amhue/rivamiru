import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/models/provider.dart';
import 'package:rivamiru/widgets/showlatest.dart';
import 'package:rivamiru/widgets/textinput.dart';

final Provider provider = Provider();

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String inputText = "";
  List<Anime> animeList = [];

  @override
  void initState() {
    getLatest();
    super.initState();
  }

  Future<void> getLatest() async {
    final data = await provider.getLatest() ?? [];

    if (!mounted) return;

    setState(() {
      animeList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rivamiru")),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            TextInput(text: ""),
            animeList.isNotEmpty
                ? Expanded(child: ShowLatest(animeList))
                : Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
