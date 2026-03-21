import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:rivamiru/screens/animescreen.dart';
import 'package:rivamiru/screens/homescreen.dart';
import 'package:rivamiru/screens/queryscreen.dart';
import 'package:rivamiru/screens/latestscreen.dart';
import 'package:rivamiru/screens/settingscreen.dart';
import 'package:rivamiru/screens/videoscreen.dart';
import 'package:rivamiru/style.dart';
import 'package:rivamiru/themes.dart';
import 'package:rivamiru/widgets/navbar.dart';
import 'dart:io';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(ChangeNotifierProvider(create: (_) => Themes(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  final router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(body: child, bottomNavigationBar: Navbar());
        },
        routes: [
          GoRoute(
            path: "/",
            pageBuilder: (context, state) =>
                NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: "/search",
            pageBuilder: (context, state) =>
                NoTransitionPage(child: LatestScreen()),
          ),
          GoRoute(
            path: "/settings",
            pageBuilder: (context, state) =>
                NoTransitionPage(child: SettingScreen()),
          ),
        ],
      ),

      GoRoute(
        path: "/watch",
        builder: (context, state) {
          return AnimeScreen(anime: state.extra as Anime);
        },
      ),

      GoRoute(
        path: "/video",
        builder: (context, state) {
          return VideoScreen(video: state.extra as Video);
        },
      ),

      GoRoute(
        path: "/query/:term",
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: QueryScreen(query: state.pathParameters['term']!),
          );
        },
      ),
    ],
  );

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Themes>(context);

    return MaterialApp.router(
      routerConfig: router,

      title: 'Rivamiru',

      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: themes[themeProvider.currentThemeIndex],
          brightness: themeProvider.darkMode
              ? Brightness.dark
              : Brightness.light,
        ),
        textTheme: TextTheme(
          titleLarge: Style.titleTheme(Theme.of(context).colorScheme),
          titleSmall: Style.smallTitleTheme(Theme.of(context).colorScheme),
          bodySmall: Style.descTheme(Theme.of(context).colorScheme),
          bodyMedium: Style.bodyTheme(Theme.of(context).colorScheme),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
