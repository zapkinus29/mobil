import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../user_model.dart';

class AuthProvider with ChangeNotifier {
  late UserCredential _currentUser;
  late UserModel _currentUserModel;
  static int currentPage = 0;

  UserCredential get currentUser => _currentUser;
  set setCurrentUser(UserCredential val) {
    _currentUser = val;
  }

  UserModel get currentMyUser => _currentUserModel;
  set setCurrentMyUser(UserModel val) {
    _currentUserModel = val;
  }
}
