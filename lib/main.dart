import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:message_basic/data/instance_binding.dart';
import 'package:message_basic/data/message_dao.dart';

import 'data/message.dart';
import 'data/user_dao.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  InstanceBinding().dependencies();
  runApp(FriendlyChatApp());
}

String _name = "Your Name";

class FriendlyChatApp extends StatelessWidget {
  const FriendlyChatApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      // initialBinding: InstanceBinding(),

      debugShowCheckedModeBanner: false,
      title: "Murad's Message",

      // call ChatScreen()

      home: ChatScreen(),
    );
  }
}

class ChatMessage extends StatelessWidget {
  DocumentSnapshot snapshot;

  ChatMessage({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;

    final message = Message.fromSnapshot(snapshot);

    final text = message.text;

    return Container(
      width: c_width,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(right: 15.0),
              child: CircleAvatar(
                child: Text(_name),
              )),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name,
                  style: TextStyle(fontSize: 20, color: Colors.green[900]),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: (Text(text)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {


  // UserDao userDao = Get.put(UserDao());

  UserDao userDao = Get.find();
  MessageDao messageDao = Get.find();

  List _messages = <ChatMessage>[].obs;

  final _textController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  bool _canSendMessage() => _textController.text.length > 0;

  void _sendMessage() {
    if (_canSendMessage()) {
      final message = Message(
        text: _textController.text,
        date: DateTime.now().toString(),
        // email: email,
      );
      messageDao.saveMessage(message);

      _textController.clear();
    }
  }


  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller:
                  _textController, // What is the function/work of this Controller?
              // onSubmitted:
              //     _handleSubmitted, // Q's = Why we didn't give the Perameters?
              //and why no String passsed?

              decoration:
                  InputDecoration.collapsed(hintText: "Write Your Message"),
              focusNode: _focusNode,

              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          Container(
              child: IconButton(
            onPressed: () => _sendMessage(),

            //Why we did .text not just the variable name?
            // How it "passes the contents of message?

            icon: Icon(Icons.send_outlined), color: Colors.green,
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Murad's Message"),
        centerTitle: true,
        backgroundColor: Colors.purple,

        actions: [
          IconButton(onPressed: (){
            userDao.logout();
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: Obx( ()=>
         userDao.isLoggedin.value
            ? buildMessageList(context)
            : Login(),
      ),
    );
  }

  Widget buildMessageList(BuildContext context) {
    return Column(
              children: [
                Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: messageDao.getMessageStream(),
                      builder: (context, snapshot) {
                        var _listOfSnapshot =
                            snapshot.data?.docs ?? []; // WHAT WE DID HERE???

                        // final message = Message.fromSnapshot(mySnapshot);

                        _messages = _listOfSnapshot
                            .map((data) => ChatMessage(snapshot: data))
                            .toList();

                        if (snapshot.hasData)
                          return ListView.builder(
                            itemBuilder: (_, int index) => _messages[index],
                            itemCount: _messages.length,
                            reverse: true,
                            padding: EdgeInsets.all(8.0),
                          );
                        else
                          return const Center(child: LinearProgressIndicator());
                      }),
                ),
                Divider(
                  height: 1.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: _buildTextComposer(),
                )
              ],
            );
  }
}
