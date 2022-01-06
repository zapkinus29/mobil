import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  firebaseSignUp(String mail, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      return ("");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('Daha güçlü bir şifre girin lütfen.');
      } else if (e.code == 'email-already-in-use') {
        return ('Bu email daha önce kullanıldı.');
      }
    } catch (e) {
      print(e);
    }
  }

  firebaseSignIn(String tcNo, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: tcNo, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  firebaseSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return auth.sendPasswordResetEmail(email: email);
  }

  firebaseUserDelete() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }
}
