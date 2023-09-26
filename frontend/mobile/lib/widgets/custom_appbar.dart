import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Floravert",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                size: 28,
              ),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/contacts');
              },
              icon: const Icon(
                Icons.chat_bubble_rounded,
                size: 26,
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            size: 28,
          ),
          color: Theme.of(context).primaryColor,
        );
      }),
    );
  }
}
