

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:message_basic/data/message.dart';
import 'package:message_basic/main.dart';

class MessageDao extends GetxController{

  static Rx<CollectionReference> messageCollection = FirebaseFirestore.instance.collection('messages').obs;

  final messages = <ChatMessage>[].obs;


  @override
  void onInit() {

    messages.bindStream(getMessageStream());

    super.onInit();
  }


   saveMessage(Message message){
    messageCollection.value.add(message.toJson());
  }

  // getMessage stream

    getMessageStream(){




      return messageCollection.value.snapshots().map((query) =>
          query.docs.map((DocumentSnapshot documentSnapshot) =>
              ChatMessage(snapshot: documentSnapshot)).toList());



  }


}