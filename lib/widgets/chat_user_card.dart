import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:quick_chat2/main.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    // const rad = 15;
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02, vertical: 5),
      color: Color.fromARGB(255, 205, 190, 251),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
          child: ListTile(
        leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
        title: Text("User Name"),
        subtitle: Text(
          "Last Message",
          maxLines: 1,
        ),
        trailing: Text(
          "12.00 PM",
          style: TextStyle(color: Colors.black54),
        ),
      )),
    );
  }
}
