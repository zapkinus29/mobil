import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/product_model.dart';
import 'package:qr_reader/providers/product_provider.dart';
import 'dart:convert';

import 'dart:typed_data';

import 'package:qr_reader/widget/my_drawer.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  bool isFav = false;
  late Product activatedProduct;
  @override
  void initState() {
    super.initState();
    activatedProduct =
        Provider.of<ProductProvider>(context, listen: false).currenProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Padding(
        padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
        child: MyDrawer(),
      ),
      appBar: AppBar(
        title: const Text("Ürün Detayı"),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                width: 200,
                child: imageFromBase64String(
                    activatedProduct.productImage.toString()),
              ),
              ListTile(
                title: Text(
                  activatedProduct.productName.toString(),
                  style: TextStyle(fontSize: 22, color: Colors.purple[800]),
                ),
                subtitle: Text(activatedProduct.productDescription.toString()),
                trailing: IconButton(
                  onPressed: () {
                    isFav = !isFav;
                    setState(() {});
                  },
                  icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.grey,
            height: MediaQuery.of(context).size.height * 4 / 10,
            child: Card(
                child: Column(
              children: [
                ListTile(
                  title: Text(
                    activatedProduct.price.toString(),
                  ),
                  subtitle: Text(
                    activatedProduct.userName.toString(),
                  ),
                  leading: Text(
                    activatedProduct.marketName.toString(),
                  ),
                  trailing: Text(activatedProduct.addedDate.toString()),
                ),
              ],
            )

                /*Row(
                    children: [
                      Text(activatedProduct.productName),
                      Text(activatedProduct.productDescription),
                      Text(activatedProduct.priceList[index].addedDate),
                      Text(
                        activatedProduct.priceList[index].userName,
                      ),
                      Text(
                        activatedProduct.priceList[index].marketName,
                      ),
                      Text(
                        activatedProduct.priceList[index].price.toString(),
                      ),
                    ],
                  );*/

                /* ListTile(
                    title: Text(activatedProduct.productName),
                    subtitle: Text(activatedProduct.productDescription),
                    leading: Text(activatedProduct.priceList[index].addedDate),
                    trailing: Row(
                      children: [
                        Text(
                          activatedProduct.priceList[index].userName,
                        ),
                        Text(
                          activatedProduct.priceList[index].marketName,
                        ),
                        Text(
                          activatedProduct.priceList[index].price.toString(),
                        ),
                      ],
                    ),
                  );*/
                ),
          ),
        ],
      ),
    );
  }
}
