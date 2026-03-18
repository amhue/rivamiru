import 'package:flutter/material.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/screens/searchscreen.dart';
import 'package:rivamiru/widgets/showlatest.dart';
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
    getLatest();
    super.initState();
  }

  Future<void> getLatest() async {
    final data = await provider.searchAnime(widget.query) ?? [];

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
            TextInput(text: widget.query),
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
