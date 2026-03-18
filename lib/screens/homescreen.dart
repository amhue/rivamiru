import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rivamiru")),
      body: Container(padding: EdgeInsets.all(20), child: Text("Hello")),
    );
  }
}
