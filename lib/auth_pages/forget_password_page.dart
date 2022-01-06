import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_reader/providers/auth_provider.dart';
import 'package:qr_reader/services/auth_service.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _mailController = TextEditingController();
  final _forgerPasswordFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Form(
        key: _forgerPasswordFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: _mailController,
              validator: (value) {
                if (emailValid(_mailController.text)) {
                  return null;
                } else {
                  return "Geçerli bir mail adresi giriniz!";
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  icon: Icon(Icons.account_box),
                  labelText: "Mail",
                  labelStyle: TextStyle(fontSize: 18),
                  contentPadding: EdgeInsets.all(4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  )),
            ),
            TextButton(
                onPressed: () {
                  if (_forgerPasswordFormKey.currentState!.validate()) {
                    AuthService().sendPasswordResetEmail(_mailController.text);
                  }
                },
                child: const Text(
                  "Mail gönder",
                  style: TextStyle(fontSize: 32),
                )),
          ],
        ),
      ),
    );
  }

  bool emailValid(String mail) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(mail);
  }
}
