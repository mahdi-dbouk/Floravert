import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Map<String, String>> contacts = [
    {
      "name": "John",
      "picture_url":
          "https://cdn3d.iconscout.com/3d/premium/thumb/hrd-manager-9642497-7825761.png?f=webp",
      "last_message": "hello there",
      "number": "3"
    },
    {
      "name": "John",
      "picture_url":
          "https://cdn3d.iconscout.com/3d/premium/thumb/hrd-manager-9642497-7825761.png?f=webp",
      "last_message": "hello there",
      "number": "5"
    },
    {
      "name": "John",
      "picture_url":
          "https://cdn3d.iconscout.com/3d/premium/thumb/hrd-manager-9642497-7825761.png?f=webp",
      "last_message": "hello there",
      "number": "0"
    },
    {
      "name": "John",
      "picture_url":
          "https://cdn3d.iconscout.com/3d/premium/thumb/hrd-manager-9642497-7825761.png?f=webp",
      "last_message": "hello there",
      "number": "0"
    },
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      contacts;
    });
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black38,
          leading: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 32.0,
                  ),
                ],
              )),
          title: const Text("Messages"),
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
        body: SafeArea(
            child: Column(children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black26))),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/chat');
                    },
                    child: ListTile(
                      title: Text(
                        contacts[index]['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(contacts[index]['last_message']!),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            NetworkImage(contacts[index]["picture_url"]!),
                      ),
                      trailing: (int.parse(contacts[index]["number"]!) > 0)
                          ? Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Text(
                                  contacts[index]["number"]!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            )
                          : const SizedBox(
                              width: 30,
                              height: 30,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ])));
  }
}
