

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_basic/data/message.dart';

class MessageDao{
  static CollectionReference messageCollection = FirebaseFirestore.instance.collection('messages');

  static saveMessage(Message message){
    messageCollection.add(message.toJson());
  }

  // getMessage stream

  Stream<QuerySnapshot> getMessageStream(){
    return messageCollection.snapshots();
  }


}