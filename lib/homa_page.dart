import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_reader/pages/add_product_page.dart';
import 'package:qr_reader/pages/favorite_page.dart';
import 'package:qr_reader/pages/profil_page.dart';
import 'package:qr_reader/pages/qr_scan_page.dart';
import 'package:qr_reader/providers/auth_provider.dart';
import 'package:qr_reader/widget/my_drawer.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  static int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    currentIndex = AuthProvider.currentPage;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddProductPage()));
          },
        ),
        drawer: const Padding(
          padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: MyDrawer(),
        ),
        appBar: AppBar(
          title: const Text("QR READER"),
        ),
        body: myPageConrroller(currentIndex),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() {
            currentIndex = index;
            AuthProvider.currentPage = index;
          }),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Ana sayfa'),
              activeColor: Colors.purpleAccent,
              inactiveColor: Colors.green,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favoriler'),
              activeColor: Colors.purpleAccent,
              inactiveColor: Colors.green,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.person_outline_sharp),
              title: Text('Profil'),
              activeColor: Colors.purpleAccent,
              inactiveColor: Colors.green,
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }

  myPageConrroller(int i) {
    if (i == 1) {
      return FavoritePage();
    } else if (i == 2) {
      return ProfilPage();
    } else {
      return (Center(
        child: TextButton(
          child: const Text(
            "Tarayıcıyı aç",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QrScanPage(),
              ),
            );
          },
        ),
      ));
    }
  }
}
