import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intl/intl.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final List<types.Message> _messages = [
    const types.TextMessage(
        author: types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ad'),
        id: 'dfkdldkdf',
        text: "hello mahdiddd"),
  ];
  Map<String, dynamic> contact = {
    "name": "John",
    "picture_url":
        "https://cdn3d.iconscout.com/3d/premium/thumb/hrd-manager-9642497-7825761.png?f=webp",
    "last_message": "hello there",
    "number": "5",
    "chats": [
      {
        "sent": "hi",
      },
      {
        "sent": "how are you?",
      },
      {
        "received": "I'm good!",
      },
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black38,
          leadingWidth: 105,
          leading: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 32.0,
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(contact["picture_url"]!),
                  ),
                ],
              )),
          titleSpacing: 1,
          title: Text(contact['name']),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    size: 24,
                    color: Colors.black,
                  )),
            ),
          ],
        ),
        body: Chat(
            customDateHeaderText: (date) => formatCustomDateHeaderText(date),
            theme: DefaultChatTheme(
                backgroundColor: Theme.of(context).colorScheme.background,
                dateDividerTextStyle: const TextStyle(color: Colors.black45),
                inputBackgroundColor: Colors.white,
                inputTextColor: Colors.black,
                primaryColor: Theme.of(context).colorScheme.primary,
                secondaryColor: Colors.black12),
            messages: _messages,
            onSendPressed: _handleSendPressed,
            user: _user));
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "sdjdskjdskfdsd",
      text: message.text,
    );
    _addMessage(textMessage);
  }

  String formatCustomDateHeaderText(DateTime dateTime) {
    final dateFormat = DateFormat('d/M/y');
    final timeFormat = DateFormat('h:mm a');
    final formattedDate = dateFormat.format(dateTime);
    final formattedTime = timeFormat.format(dateTime);

    return '$formattedDate $formattedTime';
  }
}
