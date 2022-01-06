import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qr_reader/user_model.dart';

import '../product_model.dart';

class ProductService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestoreUserSet(UserModel _userModel) {
    var _userJsonModel = UserModelConverter().userModelToJson(_userModel);
    firestore.collection('users').doc(_userModel.userMail).set(_userJsonModel);
  }

  Future<UserModel> firestoreUserGet(String mail) async {
    var _json = await firestore.collection('users').doc(mail).get();
    UserModel _user = UserModelConverter().userModelFromJson(_json.data());
    return _user;
  }

  firestoreUserDelete(String mail) {
    firestore.collection('users').doc(mail).delete();
  }

  Future<Product> firestoreProductGet(String qrCode) async {
    var _currentProduct =
        await firestore.collection("products").doc(qrCode).get();
    print(_currentProduct.data().toString());
    return ProductModelConverter().productModelFromJson(_currentProduct.data());
  }

  firestoreProductSet(Product _currentProduct) {
    var _json = ProductModelConverter().productModelToJson(_currentProduct);

    firestore.collection("products").doc(_currentProduct.qrCodeID).set(_json);
  }
}
