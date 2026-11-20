import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  void _goBranch(int index) {
    if (index == navigationShell.currentIndex) {
      navigationShell.goBranch(
        index,
        initialLocation: true,
      );
    } else {
      navigationShell.goBranch(
        index,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(label: 'Ana Sayfa', icon: Icon(Icons.home)),
          NavigationDestination(label: 'Müşteriler', icon: Icon(Icons.list_alt)),
          NavigationDestination(label: 'Ayarlar', icon: Icon(Icons.settings)),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
