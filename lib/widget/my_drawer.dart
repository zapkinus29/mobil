import 'package:flutter/material.dart';
import 'package:qr_reader/auth_pages/login_page.dart';
import 'package:qr_reader/homa_page.dart';
import 'package:qr_reader/pages/profil_page.dart';
import 'package:qr_reader/pages/qr_scan_page.dart';
import 'package:qr_reader/providers/auth_provider.dart';
import 'package:qr_reader/services/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 5 / 10,
      child: Drawer(
        child: Column(
          children: [
            const Text(
              "Qr Reader",
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
              onPressed: () {
                AuthProvider.currentPage = 0;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
              child: Text("Ana Sayfa"),
            ),
            TextButton(
                onPressed: () {
                  AuthProvider.currentPage = 2;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                },
                child: Text("Profil")),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QrScanPage(),
                      ));
                },
                child: Text("Tarayıcı")),
            TextButton(
                onPressed: () {
                  AuthService().firebaseSignOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                child: Text("Çıkış Yap")),
          ],
        ),
      ),
    );
  }
}
