import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tico_apps/constant.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: LIGHT_BLUE,
          ),
          title: Text('Ubah Password'),
        ),
        body: Container(
          padding: EdgeInsets.all(PADDING_PRIMARY),
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cek email anda Untuk\nmengubah password',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Email harus diisi';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.email_outlined),
                    label: Text(
                      'ubah password',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        resetPassword(context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }
}
