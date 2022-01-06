import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/auth_pages/forget_password_page.dart';
import 'package:qr_reader/auth_pages/login_page.dart';
import 'package:qr_reader/providers/auth_provider.dart';
import 'package:qr_reader/services/auth_service.dart';
import 'dart:convert';

import 'package:qr_reader/services/product_service.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    var _currentUser =
        Provider.of<AuthProvider>(context, listen: true).currentMyUser;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                  height: 250,
                  width: 250,
                  child: imageFromBase64String(_currentUser.userImg)),
              Text(_currentUser.userMail),
            ],
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgetPasswordPage(),
                    ),
                  );
                },
                child: Text("Şifre Değiştir"),
              ),
              TextButton(
                onPressed: () {
                  _showDialog(_currentUser.userMail);
                },
                child: Text("Hesabı Sil"),
              ),
              TextButton(
                  onPressed: () {
                    AuthService().firebaseSignOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => LoginPage()));
                  },
                  child: Text("Çıkış Yap"))
            ],
          ),
        ],
      ),
    );
  }

  void _showDialog(String mail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hesabınızı silmek istediğinize emin misiniz?"),
          content: const Text("Hesabınız tamamen silinecektir!"),
          actions: <Widget>[
            TextButton(
              child: const Text("Sil"),
              onPressed: () {
                AuthService().firebaseUserDelete();
                ProductService().firestoreUserDelete(mail);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginPage()));
              },
            ),
            TextButton(
              child: const Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }
}
