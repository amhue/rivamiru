import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),

      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,

              children: [
                Text("Dark Mode", style: TextStyle(fontSize: 16)),
                Switch(
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
