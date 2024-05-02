import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iamtalking/core/constants/app_strings.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';

class PostServices {
  PostServices();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Query<Map<String, dynamic>> getPosts() {
    return firestore.collection(AppStrings.postsCollection).orderBy('createdAt', descending: true);
  }

  Future<bool> deletePost(String postId) async {
    try {
      await firestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .delete();
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> updatePost(
      String postId, String caption, String postImage) async {
    try {
      await firestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .update({
        'postImage': postImage,
        'caption': caption,
      });
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> addPost(Map<String, dynamic> data, String postId) async {
    try {
      await firestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .set(data);
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> likePost(String postId, List likes) async {
    try {
      if (!likes.contains(auth.currentUser!.uid)) {
        await firestore
            .collection(AppStrings.postsCollection)
            .doc(postId)
            .update({
          AppStrings.likesCollection:
              FieldValue.arrayUnion([auth.currentUser!.uid])
        });
      } else {
        await firestore
            .collection(AppStrings.postsCollection)
            .doc(postId)
            .update({
          AppStrings.likesCollection:
              FieldValue.arrayRemove([auth.currentUser!.uid])
        });
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> savePost(PostModel post, String userId) async {
    try {
      await firestore
          .collection(AppStrings.postsCollection)
          .doc(post.postId)
          .update({
        'savedPost': FieldValue.arrayUnion([userId])
      });
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> unSavePost(PostModel post, String userId) async {
    try {
      await firestore
          .collection(AppStrings.postsCollection)
          .doc(post.postId)
          .update({
        'savedPost': FieldValue.arrayRemove([userId])
      });
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
