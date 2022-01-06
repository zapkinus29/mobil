import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/homa_page.dart';
import 'package:qr_reader/product_model.dart';
import 'package:qr_reader/providers/auth_provider.dart';
import 'package:qr_reader/services/product_service.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _addProductFormGlobalKey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _marketNameController = TextEditingController();
  late String _img64;
  File? imgFile;
  final imgPicker = ImagePicker();
  String price = "";
  List priceList = [0, 0];

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Seçenekler"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Kamera Kullanın"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Galeri Kullanın"),
                    onTap: () {
                      openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera() async {
    var imgCamera =
        await imgPicker.pickImage(source: ImageSource.camera, imageQuality: 25);
    setState(() {
      imgFile = File(imgCamera!.path);
    });
    Navigator.of(context).pop();
  }

  void openGallery() async {
    var imgGallery = await imgPicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      imgFile = File(imgGallery!.path);
    });
    Navigator.of(context).pop();
  }

  Widget displayImage() {
    if (imgFile == null) {
      return Text("Resim seçilmedi!");
    } else {
      final bytes = imgFile!.readAsBytesSync();
      _img64 = base64Encode(bytes);
      return Image.file(
        imgFile!,
        width: 250,
        height: 150,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Reader"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormGlobalKey,
          child: Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    displayImage(),
                    SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        showOptionsDialog(context);
                      },
                      child: Text("Görsel Seçiniz"),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                child: TextFormField(
                  controller: _productNameController,
                  validator: (value) {
                    if (value!.length > 2)
                      return null;
                    else
                      return "Lütfen 3 haneden uzun bir isim!";
                  },
                  decoration: const InputDecoration(
                      icon: Icon(Icons.production_quantity_limits),
                      labelText: "Ürün Adı",
                      labelStyle: TextStyle(fontSize: 18),
                      contentPadding: EdgeInsets.all(4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      )),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                child: TextFormField(
                  controller: _productDescriptionController,
                  validator: (value) {
                    if (value!.length > 0)
                      return null;
                    else
                      return "Lütfen bir açıklama giriniz!";
                  },
                  decoration: const InputDecoration(
                      icon: Icon(Icons.description),
                      labelText: "Ürün Açıklaması",
                      labelStyle: TextStyle(fontSize: 18),
                      contentPadding: EdgeInsets.all(4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      )),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Fiyat"),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                    child: CustomNumberPicker(
                      initialValue: 0,
                      maxValue: 1000,
                      minValue: 0,
                      step: 1,
                      enable: true,
                      onValue: (value) {
                        priceList[0] = value;
                      },
                    ),
                  ),
                  Text("."),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                    child: CustomNumberPicker(
                      initialValue: 0,
                      maxValue: 99,
                      minValue: 0,
                      step: 1,
                      enable: true,
                      onValue: (num value) {
                        priceList[1] = value;
                      },
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                child: TextFormField(
                  controller: _marketNameController,
                  validator: (value) {
                    if (value!.length > 2)
                      return null;
                    else
                      return "Lütfen en az 2 harfli bir market adı giriniz!";
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.account_box),
                    labelText: "Market Adı",
                    labelStyle: TextStyle(fontSize: 18),
                    contentPadding: EdgeInsets.all(4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.purple[800],
                    ),
                    padding: EdgeInsets.all(5),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomePage(),
                            ));
                      },
                      child: const Text(
                        "İptal",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.purple[800],
                    ),
                    padding: EdgeInsets.all(3),
                    child: TextButton(
                      onPressed: () {
                        if (_addProductFormGlobalKey.currentState!.validate() &&
                            _img64.isNotEmpty) {
                          double number01 =
                              priceList[0] + (priceList[1] * 1 / 100);
                          Product currentProduct = Product(
                            _productNameController.text,
                            "${_productNameController.text}${_productDescriptionController.text}",
                            _productDescriptionController.text,
                            _img64,
                            authProvider.currentMyUser.userMail,
                            DateTime.now().toString(),
                            _marketNameController.text,
                            number01.toString(),
                          );
                          ProductService().firestoreProductSet(currentProduct);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomePage()));
                        }
                      },
                      child: const Text(
                        "Kaydet",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),

              //  Text("Ekleyen kullanıcı"),

              //  Text("Eklenme tarihi"),
            ],
          ),
        ),
      ),
    );
  }
}
