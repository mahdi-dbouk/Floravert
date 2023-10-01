import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intl/intl.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

final String baseUrl = dotenv.env['BASE_URL'] ?? "";

class Chats extends StatefulWidget {
  final String username;
  final String traderEmail;
  final String profilePic;
  const Chats(
      {super.key,
      required this.username,
      required this.traderEmail,
      required this.profilePic});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  late IO.Socket _socket;
  String socketId = '';
  types.User _user = types.User(id: '');

  @override
  void initState() {
    super.initState();
    initializeSocketConnection();
  }

  void initializeSocketConnection() {
    String email =
        Provider.of<AuthProvider>(context, listen: false).user.email!;
    _socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    print(email);
    _socket.auth = {'email': email};

    _socket.connect();

    _socket.on('connect', (data) {
      _user = types.User(id: const Uuid().v4());
    });
    _socket.on('authRequest', (message) {
      var data = {'email': email};
      _socket.emit('authResponse', data);
    });

    _socket.on('authSuccess', (data) {});

    _socket.on('received_message', (data) {
      types.TextMessage message = types.TextMessage(
          author: types.User(id: data['id']),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: data['content']);
      _addMessage(message);
    });
    _socket.on('error', (error) => print(error));
    _socket.on('disconnect', (e) => print(e));
  }

  @override
  void dispose() {
    _socket.disconnect();
    super.dispose();
  }

  final List<types.Message> _messages = [];

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
                    backgroundImage: NetworkImage(widget.profilePic ??
                        "https://i.stack.imgur.com/y9DpT.jpg"),
                  ),
                ],
              )),
          titleSpacing: 1,
          title: Text(widget.username),
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
      id: Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);
    _socket.emit(
        'send_message', {'to': widget.traderEmail, 'content': message.text});
  }

  String formatCustomDateHeaderText(DateTime dateTime) {
    final dateFormat = DateFormat('d/M/y');
    final timeFormat = DateFormat('h:mm a');
    final formattedDate = dateFormat.format(dateTime);
    final formattedTime = timeFormat.format(dateTime);

    return '$formattedDate $formattedTime';
  }
}
