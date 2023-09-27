import 'package:flutter/material.dart';

class CustomBottomNavigator extends StatefulWidget {
  const CustomBottomNavigator({super.key});

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle:
          TextStyle(color: Theme.of(context).colorScheme.primary),
      unselectedLabelStyle: TextStyle(color: Colors.grey.shade400),
      items: [
        BottomNavigationBarItem(
            label: 'Home',
            icon: (_currentIndex == 0)
                ? Icon(Icons.home,
                    size: 24, color: Theme.of(context).primaryColor)
                : Icon(Icons.home, size: 24, color: Colors.grey.shade400)),
        BottomNavigationBarItem(
            label: 'Map',
            icon: (_currentIndex == 0)
                ? Icon(Icons.map,
                    size: 24, color: Theme.of(context).primaryColor)
                : Icon(Icons.map, size: 28, color: Colors.grey.shade400)),
        BottomNavigationBarItem(
            label: 'Market',
            icon: (_currentIndex == 0)
                ? Icon(Icons.store,
                    size: 24, color: Theme.of(context).primaryColor)
                : Icon(Icons.store, size: 24, color: Colors.grey.shade400)),
      ],
    );
  }
}
