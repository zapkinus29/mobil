import 'package:flutter/material.dart';

import '../product_model.dart';

class ProductProvider with ChangeNotifier {
  late Product _product;
  Product get currenProduct => _product;
  set setCurrentProduct(Product val) {
    _product = val;
  }
}
