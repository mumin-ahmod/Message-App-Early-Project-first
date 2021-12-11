import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late String text;
  final DateTime date;
  final String? email;

  DocumentReference? reference;

  Message({required this.text, required this.date, this.email, this.reference});

  // add JSON converters



  Map<String, dynamic> toJson() {

    var map = {
      "text" : text,
      "date" : date.toString(),
      "email" : email
    };

    return map;

  }

  factory Message.fromJson(Map<String, dynamic> json) => Message(text: json["text"], date: json["date"], email: json["email"]);

  // add fromsnapshot


  factory Message.fromSnapshot(DocumentSnapshot snapshot){
    final message = Message.fromJson(snapshot.data() as Map<String, dynamic>);

    message.reference = snapshot.reference; // fromJSON handles everything, meaning it takes - text, date and email from snapshot but we need docReference too.

    return message;
  }
}
