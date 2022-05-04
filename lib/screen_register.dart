import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen_login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassWd = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';

  final clientFirebase = FirebaseAuth.instance;

  Future<void> registerFirebase(
      {required String email, required String password}) async {
    final user = await clientFirebase.createUserWithEmailAndPassword(
        email: email, password: password);
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
          ),
        ],
      ),
      body: Center(
        child: Column(children: <Widget>[
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
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextFormField(
              controller: _controllerPassWd,
              validator: validatePasswd,
              obscureText: true,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Secure Password'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                if (_key.currentState!.validate()) {
                  await registerFirebase(
                      email: _controllerEmail.text,
                      password: _controllerPassWd.text);

                  errorMessage = '';
                }
              } on FirebaseAuthException catch (error) {
                errorMessage = error.message!;
              }
            },
            child: const Text('Create Account'),
          ),
        ]),
      ),
    );
  }
}
