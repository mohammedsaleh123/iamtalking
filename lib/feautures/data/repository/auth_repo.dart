import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iamtalking/core/services/services_locator.dart';
import 'package:iamtalking/feautures/data/services/auth_services.dart';

class AuthRepo {
  AuthRepo();
  AuthServices firebaseAuthServices = sl<AuthServices>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> signIn(String email, String password) async {
    return await firebaseAuthServices.signIn(email, password);
  }

  Future<bool> signUp(String userName, String email, String password,
      String profileImage, String imagePath) async {
    return await firebaseAuthServices.signUp(
        userName, email, password, profileImage, imagePath);
  }

  Future<bool> loginWithGoogle() async {
    return await firebaseAuthServices.loginWithGoogle();
  }

  Future<void> signOut() async {
    await firebaseAuthServices.signOut();
  }
}
