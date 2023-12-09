import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_chat2/api/apis.dart';
import 'package:quick_chat2/widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: Text('Quick Chat'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_comment_rounded),
      ),
      body: StreamBuilder(
          stream: APIs.firestore.collection('user').snapshots(),
          builder: (context, snapshot) {
            final nameList = [];
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              for (var i in data!) {
                log('data: ${i.data()}');
                nameList.add(i.data()['name']);
              }
              // log('data: ${data.length}');
            }
            return ListView.builder(
              itemCount: nameList.length,
              // scrollDirection: ,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatUserCard();
              },
            );
          }),
    );
  }
}
