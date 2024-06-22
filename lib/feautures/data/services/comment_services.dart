import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/constants/app_strings.dart';

class CommentServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> likeComment(String postId, String commentId) async {
    try {
      await firestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .collection(AppStrings.commentsCollection)
          .doc(commentId)
          .update(
        {
          AppStrings.likesCollection:
              FieldValue.arrayUnion([auth.currentUser!.uid])
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> unLikeComment(String postId, String commentId) async {
    try {
      await firestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .collection(AppStrings.commentsCollection)
          .doc(postId)
          .update(
        {
          AppStrings.likesCollection:
              FieldValue.arrayRemove([auth.currentUser!.uid])
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addComment(
      String postId, String commentId, Map<String, dynamic> data) async {
    try {
      await firestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .collection(AppStrings.commentsCollection)
          .doc(commentId)
          .set(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteComment(String postId, String commentId) async {
    try {
      await firestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .collection(AppStrings.commentsCollection)
          .doc(commentId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateComment(
      String postId, String commentId, Map<String, dynamic> data) async {
    try {
      await firestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .collection(AppStrings.commentsCollection)
          .doc(postId)
          .update(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Query<Map<String, dynamic>> getComments(String postId) {
    return firestore
        .collection(AppStrings.postsCollection)
        .doc(postId)
        .collection(AppStrings.commentsCollection)
        .orderBy('date', descending: false);
  }
}
