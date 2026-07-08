import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      height: 72,
      elevation: 3,
      animationDuration: const Duration(milliseconds: 500),

      destinations: const [
  NavigationDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home),
    label: "Home",
  ),
  NavigationDestination(
    icon: Icon(Icons.description_outlined),
    selectedIcon: Icon(Icons.description),
    label: "Reports",
  ),
  NavigationDestination(
    icon: Icon(Icons.medication_outlined),
    selectedIcon: Icon(Icons.medication),
    label: "Medicine",
  ),
  NavigationDestination(
    icon: Icon(Icons.smart_toy_outlined),
    selectedIcon: Icon(Icons.smart_toy),
    label: "AI",
  ),
  NavigationDestination(
    icon: Icon(Icons.person_outline),
    selectedIcon: Icon(Icons.person),
    label: "Profile",
  ),
],
    );
  }
}