import 'package:flutter/material.dart';

class CustomBottomNavigator extends StatefulWidget {
  const CustomBottomNavigator({super.key});

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shadowColor: Colors.black,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.home,
                  size: 28, color: Theme.of(context).primaryColor)),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.map,
                size: 28,
                color: Colors.grey.shade400,
              )),
          const SizedBox(width: 28),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.store,
                size: 28,
                color: Colors.grey.shade400,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.post_add,
                size: 28,
                color: Colors.grey.shade400,
              ))
        ],
      ),
    );
  }
}
