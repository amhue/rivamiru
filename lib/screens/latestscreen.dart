import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/models/provider.dart';
import 'package:rivamiru/widgets/showlist.dart';
import 'package:rivamiru/widgets/textinput.dart';
import 'package:rivamiru/widgets/texts.dart';

class LatestScreen extends StatefulWidget {
  const LatestScreen({super.key});

  @override
  State<LatestScreen> createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> {
  String inputText = "";
  List<Anime> animeList = [];

  @override
  void initState() {
    getLatest();
    super.initState();
  }

  Future<void> getLatest() async {
    final data = await Provider().getLatest() ?? [];

    if (!mounted) return;

    setState(() {
      animeList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: Container(
        padding: EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: getLatest,
          child: ListView(
            children: [
              TextInput(text: ""),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: TitleSmall(data: "Latest Released"),
              ),

              animeList.isNotEmpty
                  ? ShowList(animeList)
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
