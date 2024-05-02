import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iamtalking/core/constants/app_strings.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';

class AuthServices {
  AuthServices();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String userName, String email, String password,
      String profileImage, String imagePath) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firestore
          .collection(AppStrings.usersCollection)
          .doc(auth.currentUser!.uid)
          .set(
            UserAuthModel(
              uid: auth.currentUser!.uid,
              userName: userName,
              email: email,
              profileImage: profileImage,
              imagePath: imagePath,
              createdAt: Timestamp.now(),
              following: [],
              followers: [],
              savedChats: [],
            ).toJson(),
          );
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
