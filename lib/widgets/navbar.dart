import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    String uri = GoRouterState.of(context).uri.toString();
    late int index;

    if (uri == "/") {
      index = 0;
    } else if (uri == "/search") {
      index = 1;
    } else {
      index = 2;
    }

    return NavigationBar(
      onDestinationSelected: (int index) {
        switch (index) {
          case 0:
            context.go("/");
            break;
          case 1:
            context.go("/search");
            break;
          case 2:
            context.go("/settings");
            break;
          default:
        }
      },

      selectedIndex: index,

      destinations: [
        NavigationDestination(
          icon: Icon(Icons.video_collection_outlined),
          selectedIcon: Icon(Icons.video_collection),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: "Search",
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
    );
  }
}
