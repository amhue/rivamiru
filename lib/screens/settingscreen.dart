import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivamiru/themes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Themes>(context);

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
                  value: themeProvider.darkMode,
                  onChanged: (value) {
                    themeProvider.darkMode = value;
                  },
                ),
              ],
            ),

            Wrap(
              children: themes
                  .asMap()
                  .entries
                  .map(
                    (e) => InkWell(
                      onTap: () => themeProvider.currentThemeIndex = e.key,

                      child: Padding(
                        padding: EdgeInsets.all(5),

                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                              width: 2,
                            ),
                            color: e.value,
                          ),

                          child: themeProvider.currentThemeIndex == e.key
                              ? Icon(Icons.check)
                              : null,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
