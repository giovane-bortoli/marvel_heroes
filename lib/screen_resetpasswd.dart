import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'app_widget.dart';
import 'screen_login.dart';

class resetPassWd extends StatefulWidget {
  const resetPassWd({Key? key}) : super(key: key);

  @override
  State<resetPassWd> createState() => _resetPassWdState();
}

class _resetPassWdState extends State<resetPassWd> {
  final clientFirebase = FirebaseAuth.instance;
  final TextEditingController _controllerEmail = TextEditingController();

  Future<void> resetFirebase({required email}) async {
    await clientFirebase.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _controllerEmail,
                  validator: validateEmail,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Enter valid Email'),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await resetFirebase(email: _controllerEmail.text);
                Navigator.popAndPushNamed(context, '/login');
              },
              child: const Text(
                'Reset Password',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
