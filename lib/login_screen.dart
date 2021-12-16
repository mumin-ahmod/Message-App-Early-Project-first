import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_basic/data/user_dao.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserDao userDao = Get.find();
    return Scaffold(

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Log-in to MMessage", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Email Address',
                ),
                autofocus: false,

                keyboardType: TextInputType.emailAddress,
                // 3
                textCapitalization: TextCapitalization.none,

                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter Password',
                ),
                autofocus: false,

                keyboardType: TextInputType.emailAddress,
                // 3
                textCapitalization: TextCapitalization.none,

                controller: _passwordController,
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
                onPressed: () {
                  userDao.login(
                      _emailController.text, _passwordController.text);
                },
                child: Text("Login")),

            SizedBox(height: 20),

            ElevatedButton(
                onPressed: () {
                  userDao.signup(
                      _emailController.text, _passwordController.text);
                },
                child: Text("Sign Up")),

            SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }
}
