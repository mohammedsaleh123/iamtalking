import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:iamtalking/core/constants/app_strings.dart';

class UserServices {
  UserServices();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUser() {
    try {
      Stream<DocumentSnapshot<Map<String, dynamic>>> snapshot = firestore
          .collection(AppStrings.usersCollection)
          .doc(auth.currentUser!.uid)
          .snapshots();
      return snapshot;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(String uid) {
    final snapshot =
        firestore.collection(AppStrings.usersCollection).doc(uid).snapshots();
    return snapshot;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    final snapshot =
        firestore.collection(AppStrings.usersCollection).snapshots();
    return snapshot;
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await firestore
        .collection(AppStrings.usersCollection)
        .doc(uid)
        .update(data);
  }

  Future<void> deleteUser(String uid) async {
    await firestore.collection(AppStrings.usersCollection).doc(uid).delete();
  }

  Future<void> followUser(String otherUserId) async {
    await firestore
        .collection(AppStrings.usersCollection)
        .doc(auth.currentUser!.uid)
        .update({
      AppStrings.followingCollection: FieldValue.arrayUnion([otherUserId])
    });
    await firestore
        .collection(AppStrings.usersCollection)
        .doc(otherUserId)
        .update({
      AppStrings.followersCollection:
          FieldValue.arrayUnion([auth.currentUser!.uid])
    });
  }

  Future<void> unfollowUser(String otherUserId) async {
    await firestore
        .collection(AppStrings.usersCollection)
        .doc(auth.currentUser!.uid)
        .update({
      AppStrings.followingCollection: FieldValue.arrayRemove([otherUserId])
    });
    await firestore
        .collection(AppStrings.usersCollection)
        .doc(otherUserId)
        .update({
      AppStrings.followersCollection:
          FieldValue.arrayRemove([auth.currentUser!.uid])
    });
  }
}
