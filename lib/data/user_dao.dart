import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class UserDao extends GetxController{
 final auth = FirebaseAuth.instance;

  // add healper methods


  bool isLoggedIn(){
    return auth.currentUser != null;
  }

  String? userId(){
    return auth.currentUser?.uid;
  }

  String? email(){
    return auth.currentUser?.email;
  }

  // add sign up

  void signup(String email, String password) async {


    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch(e) {
      if(e.code == "weak-password"){
        print("The password provided is too weak.");
      }
      else if(e.code == "email-already-in-use"){
        print('The account already exists for that email.');

      }
    }
    catch(e){
      print(e);
    }

  }

  // add login

  void login(String email, String password) async {

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      if(e.code == "weak-password"){
        print("The password provided is too weak.");
      }
      else if(e.code == "email-already-in-use"){
        print('The account already exists for that email.');

      }
    } catch(e) {
      print(e);
    }

  }

  // add logout

  void logout()async{
    auth.signOut();
  }
}