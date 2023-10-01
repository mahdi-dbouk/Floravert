import 'package:flutter/material.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (BuildContext context, authUserModel, child) => AppBar(
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
          return Row(
            children: [
              SizedBox(
                width: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/profile');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.primary)),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(authUserModel.user.pictureUrl!),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
