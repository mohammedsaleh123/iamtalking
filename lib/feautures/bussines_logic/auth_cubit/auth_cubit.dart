import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iamtalking/core/constants/app_strings.dart';
import 'package:iamtalking/core/services/services_locator.dart';
import 'package:iamtalking/feautures/data/repository/auth_repo.dart';
import 'package:iamtalking/core/helper/picke_file_helper.dart';
import 'package:iamtalking/core/helper/upload_to_storage_helper.dart';
import 'package:iamtalking/generated/l10n.dart';
import 'package:uuid/uuid.dart';

part 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthInitial());

  static AuthBloc get(context) => BlocProvider.of(context);

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController =
      TextEditingController();
  File? profileImage;
  AuthRepo authRepo = sl<AuthRepo>();
  PickeFileHelper pickeFileServices = sl<PickeFileHelper>();
  UploadToStorageHelper uploadToStorageHelper = sl<UploadToStorageHelper>();

  Future<bool> loginWithGoogle() async {
    return await authRepo.loginWithGoogle();
  }

  void signIn(BuildContext context) {
    emit(LoginLoading());
    authRepo
        .signIn(
      loginEmailController.text,
      loginPasswordController.text,
    )
        .then((value) {
      if (value) {
        emit(LoginSuccess());
        clearLoginField();
      }
    }).catchError((err) {
      emit(LoginFailed(err.toString()));
    });
  }

  void clearLoginField() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  Future<void> signUp(BuildContext context) async {
    emit(RegisterLoading());
    String uuid = const Uuid().v4();
    String image = '';
    if (profileImage == null) {
      emit(RegisterFailed(S.of(context).please_upload_your_profile_image));
    } else {
      image = await uploadToStorageHelper.uploadFile(
          path: AppStrings.profileImages, file: profileImage!, uuid: uuid);
      authRepo
          .signUp(
              registerNameController.text,
              registerEmailController.text,
              registerPasswordController.text,
              image,
              '${AppStrings.profileImages}/$uuid')
          .then(
        (value) {
          if (value) {
            emit(RegisterSuccess());
            clearRegisterField();
          } 
        },
      ).catchError(
        (err) {
          emit(RegisterFailed(err.toString()));
        },
      );
    }
  }

  void clearRegisterField() {
    registerNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
    profileImage = null;
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await authRepo.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailed(e.toString()));
    }
  }

  File? uploadProfileImage(String type, String source) {
    emit(UploadProfileImageLoading());
    try {
      pickeFileServices.pickFile(type, source).then(
        (value) {
          profileImage = File(value!.path);
          emit(UploadProfileImageSuccess());
        },
      );
      return profileImage;
    } catch (e) {
      emit(UploadProfileImageFailed(e.toString()));
    }
    return null;
  }
}
