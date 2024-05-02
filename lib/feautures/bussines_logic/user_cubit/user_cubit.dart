import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iamtalking/core/services/services_locator.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';
import 'package:iamtalking/feautures/data/repository/user_repo.dart';

part 'user_state.dart';

class UserBloc extends Cubit<UserState> {
  UserBloc() : super(UserInitial());

  static UserBloc get(context) => BlocProvider.of<UserBloc>(context);
  UserRepo userRepo = sl<UserRepo>();

  Stream<UserAuthModel> getCurrentUser() {
    return userRepo.getCurrentUser();
  }

  Stream<UserAuthModel> getUser(String uid) {
    return userRepo.getUser(uid);
  }

  Future<bool> followUser(String otherUserId) async {
    emit(FollowUserLoading());
    try {
      await userRepo.followUser(otherUserId);
      emit(FollowUserSuccess());
      return true;
    } catch (e) {
      emit(FollowUserFailed(e.toString()));
      return false;
    }
  }

  Future<bool> unfollowUser(String otherUserId) async {
    emit(UnfollowUserLoading());
    try {
      await userRepo.unfollowUser(otherUserId);
      emit(UnfollowUserSuccess());
      return true;
    } catch (e) {
      emit(UnfollowUserFailed(e.toString()));
      return false;
    }
  }

  Future<bool> updateUser(String uid, Map<String, dynamic> data) async {
    emit(UpdateUserLoading());
    try {
      await userRepo.updateUser(uid, data);
      emit(UpdateUserSuccess());
      return true;
    } catch (e) {
      emit(UpdateUserFailed(e.toString()));
      return false;
    }
  }

  Future<bool> deleteUser(String uid) async {
    emit(DeleteUserLoading());
    try {
      await userRepo.deleteUser(uid);
      emit(DeleteUserSuccess());
      return true;
    } catch (e) {
      emit(DeleteUserFailed(e.toString()));
      return false;
    }
  }
}
