import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iamtalking/core/constants/app_strings.dart';
import 'package:iamtalking/core/services/services_locator.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';
import 'package:iamtalking/feautures/data/repository/post_repo.dart';
import 'package:iamtalking/core/helper/date_formate_helper.dart';
import 'package:iamtalking/core/helper/picke_file_helper.dart';
import 'package:iamtalking/core/helper/upload_to_storage_helper.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

part 'post_state.dart';

class PostBloc extends Cubit<PostState> {
  PostBloc() : super(PostInitial());

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  PostRepo postRepo = sl<PostRepo>();
  TextEditingController captionController = TextEditingController();
  TextEditingController editCaptionController = TextEditingController();
  PickeFileHelper pickeFileServices = sl<PickeFileHelper>();
  UploadToStorageHelper uploadToStorageHelper = sl<UploadToStorageHelper>();
  VideoPlayerController? videoController;
  File? postImage;
  bool isVideo = false;
  bool isPlay = false;
  String postImageToEdit = '';

  Future<void> addPost(UserAuthModel user) async {
    emit(AddPostLoading());
    String uuid = const Uuid().v4();
    try {
      final image = await uploadToStorageHelper.uploadFile(
        path: AppStrings.postImages,
        file: postImage!,
        uuid: uuid,
      );
      final data = PostModel(
        caption: captionController.text,
        postId: uuid,
        userId: auth.currentUser!.uid,
        userName: user.userName,
        userImage: user.profileImage,
        postImage: image,
        postVideo: isVideo ? postImage!.path : '',
        imagePath: '${AppStrings.postImages}/$uuid',
        likes: [],
        savedPost: [],
        createdAt: Timestamp.now(),
      ).toJson();
      await postRepo.addPost(data, uuid);
      captionController.clear();
      postImage = null;
      emit(AddPostSuccess());
    } catch (e) {
      emit(AddPostFailed(e.toString()));
    }
  }

  Future<void> updatePost(PostModel post, String postId) async {
    emit(UpdatePostLoading());
    String uuid = const Uuid().v4();
    try {
      if (postImage != null) {
        storage.ref(post.imagePath).delete();
      }
      final image = postImage != null
          ? await uploadToStorageHelper.uploadFile(
              path: AppStrings.postImages,
              file: postImage!,
              uuid: uuid,
            )
          : post.postImage;
      await postRepo.updatePost(postId, editCaptionController.text, image);
      postImage = null;
      postImageToEdit = '';
      editCaptionController.clear();
      emit(UpdatePostSuccess());
    } catch (e) {
      emit(UpdatePostFailed(e.toString()));
    }
  }

  Future<void> deletePost(String postId, String imagePath) async {
    emit(DeletePostLoading());
    try {
      await postRepo.deletePost(postId);
      storage.ref(imagePath).delete();
      emit(DeletePostSuccess());
    } catch (e) {
      emit(DeletePostFailed(e.toString()));
    }
  }

  Future<void> likePost(String postId, List likes) async {
    emit(LikePostLoading());
    try {
      await postRepo.likePost(postId, likes);
      emit(LikePostSuccess());
    } catch (e) {
      emit(LikePostFailed(e.toString()));
    }
  }

  Future<bool> savePost(PostModel post, String userId) async {
    emit(SavePostLoading());
    try {
      final result = await postRepo.savePost(post, userId);
      emit(SavePostSuccess());
      return result;
    } catch (e) {
      emit(SavePostFailed(e.toString()));
      return false;
    }
  }

  Future<bool> unSavePost(PostModel post, String userId) async {
    emit(UnSavePostLoading());
    try {
      final result = await postRepo.unSavePost(post, userId);
      emit(UnSavePostSuccess());
      return result;
    } catch (e) {
      emit(UnSavePostFailed(e.toString()));
      return false;
    }
  }

  Stream<List<PostModel>> getAllPosts() {
      return postRepo.getAllPosts();
  }

  File? uploadPostImage(String type, String source) {
    emit(UploadProfileImageLoading());
    try {
      pickeFileServices.pickFile(type, source).then((value) {
        postImage = File(value!.path);
        if (type == AppStrings.video) {
          isVideo = true;
          videoController = VideoPlayerController.file(postImage!)
            ..initialize();
          videoController!.play();
        }
        emit(UploadProfileImageSuccess());
      });
      return postImage;
    } catch (e) {
      emit(UploadProfileImageFailed(e.toString()));
    }
    return null;
  }

  String formatDate(DateTime date) {
    return DateFormatHelper.formatDate(date);
  }

  void clearPostField() {
    captionController.clear();
    postImage = null;
    isVideo = false;
    videoController!.dispose();
  }

  void changePlayState() {
    emit(PlayVideoLoading());
    try {
      isPlay = !isPlay;
      emit(PlayVideoSuccess());
    } on Exception catch (e) {
      emit(PlayVideoFailed(e.toString()));
      debugPrint(e.toString());
    }
  }

  void pathPostToEditView(PostModel post) {
    emit(PathPostToEditViewLoading());
    try {
      postImageToEdit = post.postImage;
      editCaptionController.text = post.caption!;
      emit(PathPostToEditViewSuccess());
    } on Exception catch (e) {
      emit(PathPostToEditViewFailed(e.toString()));
      debugPrint(e.toString());
    }
  }
}
