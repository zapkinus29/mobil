//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/auth_pages/forget_password_page.dart';
import 'package:qr_reader/services/product_service.dart';

import '../providers/auth_provider.dart';
import '../services/auth_service.dart';
import '../homa_page.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _signInFormGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _signInFormGlobalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 75,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                  child: TextFormField(
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
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        contentPadding: EdgeInsets.all(4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 22),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      return value!.length < 6
                          ? "Parolanız en az 6 haneli olmalı"
                          : null;
                    },
                    decoration: const InputDecoration(
                        icon: Icon(Icons.password_outlined),
                        labelText: "Şifre",
                        labelStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.all(4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordPage()));
                        },
                        child: const Text("Şifremi Unuttum!")),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size.fromWidth(200),
                    side: const BorderSide(width: 8, color: Colors.grey),
                    backgroundColor: Colors.purple[900],
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: 66),
                  ),
                  onPressed: () {
                    if (_signInFormGlobalKey.currentState!.validate()) {
                      signIn();
                    }
                  },
                  child: const Text("Giriş Yap"),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size.fromWidth(200),
                    side: const BorderSide(width: 8, color: Colors.grey),
                    backgroundColor: Colors.purple[900],
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: 66),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  child: const Text("Kayıt Ol "),
                ),
              ],
            )),
      ),
    );
  }

  signIn() async {
    var user = await AuthService()
        .firebaseSignIn(_mailController.text, _passwordController.text);
    var myUser;
    user != null
        ? {
            myUser =
                await ProductService().firestoreUserGet(_mailController.text),
            Provider.of<AuthProvider>(context, listen: false).setCurrentUser =
                user,
            Provider.of<AuthProvider>(context, listen: false).setCurrentMyUser =
                myUser,
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                )),
          }
        : ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kullanıcı bulunamadı'),
            ),
          );
  }

  bool emailValid(String mail) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(mail);
  }
}
