

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:message_basic/data/message.dart';

class MessageDao extends GetxController{

  static Rx<CollectionReference> messageCollection = FirebaseFirestore.instance.collection('messages').obs;

   saveMessage(Message message){
    messageCollection.value.add(message.toJson());
  }

  // getMessage stream

   Stream<QuerySnapshot> getMessageStream(){
    return messageCollection.value.snapshots();
  }


}