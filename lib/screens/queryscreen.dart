import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/models/provider.dart';
import 'package:rivamiru/widgets/showlist.dart';
import 'package:rivamiru/widgets/textinput.dart';

class QueryScreen extends StatefulWidget {
  final String query;

  const QueryScreen({required this.query, super.key});

  @override
  State<QueryScreen> createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  String inputText = "";
  List<Anime> animeList = [];

  @override
  void initState() {
    searchAnime();
    super.initState();
  }

  Future<void> searchAnime() async {
    final data = await Provider().searchAnime(widget.query) ?? [];

    if (!mounted) return;

    setState(() {
      animeList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results for ${widget.query}")),
      body: Container(
        padding: EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: searchAnime,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: TextInput(text: widget.query),
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
