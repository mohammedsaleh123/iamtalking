import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iamtalking/core/helper/picke_file_helper.dart';
import 'package:iamtalking/feautures/data/models/comment_model.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';
import 'package:iamtalking/feautures/data/repository/comment_repo.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/helper/upload_to_storage_helper.dart';
import '../../../core/services/services_locator.dart';

part 'comment_state.dart';

class CommentBloc extends Cubit<CommentState> {
  CommentBloc() : super(CommentInitial());

  CommentRepo commentRepo = sl<CommentRepo>();
  UploadToStorageHelper uploadToStorageHelper = sl<UploadToStorageHelper>();
  final pickeFileServices = sl<PickeFileHelper>();
  TextEditingController commentController = TextEditingController();
  File? commentImage;

  Future<void> addComment(String postId, UserAuthModel user) async {
    emit(AddCommentLoading());
    String uuid = const Uuid().v4();
    final image = commentImage != null
        ? await uploadToStorageHelper.uploadFile(
            path: AppStrings.commentImages,
            file: commentImage!,
            uuid: uuid,
          )
        : null;
    final data = CommentModel(
      commentId: uuid,
      comment: commentController.text,
      userId: user.uid,
      postId: postId,
      userName: user.userName,
      userImage: user.profileImage,
      date: Timestamp.now(),
      likes: [],
      commentImage: image ?? '',
    ).toMap();
    try {
      await commentRepo.addComment(postId,uuid, data);
      emit(AddCommentSuccess());
      commentController.clear();
      commentImage = null;
    } catch (e) {
      emit(AddCommentFailed(e.toString()));
    }
  }

  Future<void> deleteComment(String postId, String commentId) async {
    emit(DeleteCommentLoading());
    try {
      await commentRepo.deleteComment(postId, commentId);
      emit(DeleteCommentSuccess());
    } catch (e) {
      emit(DeleteCommentFailed(e.toString()));
    }
  }

  Future<void> updateComment(
      String postId, String commentId, Map<String, dynamic> data) async {
    emit(UpdateCommentLoading());
    try {
      await commentRepo.updateComment(postId, commentId, data);
      emit(UpdateCommentSuccess());
    } catch (e) {
      emit(UpdateCommentFailed(e.toString()));
    }
  }

  Future<void> likeComment(String postId, String commentId) async {
    emit(LikeCommentLoading());
    try {
      await commentRepo.likeComment(postId, commentId);
      emit(LikeCommentSuccess());
    } catch (e) {
      emit(LikeCommentFailed(e.toString()));
    }
  }

  Future<void> unlikeComment(String postId, String commentId) async {
    emit(UnlikeCommentLoading());
    try {
      await commentRepo.unlikeComment(postId, commentId);
      emit(UnlikeCommentSuccess());
    } catch (e) {
      emit(UnlikeCommentFailed(e.toString()));
    }
  }

  Stream<List<CommentModel>> getComments(String postId) {
    try {
      commentRepo.getComments(postId);
      return commentRepo.getComments(postId);
    } catch (e) {
      rethrow;
    }
  }

  File? uploadCommentImage(String type, String source) {
    File? file;
    emit(UploadCommentImageLoading());
    try {
      pickeFileServices.pickFile(type, source).then((value) {
        commentImage = File(value!.path);
        file = commentImage;
        if (type == AppStrings.video) {
        }
        emit(UploadCommentImageSuccess());
      });
      return file;
    } catch (e) {
      emit(UploadCommentImageFailed(e.toString()));
    }
    return null;
  }
}
