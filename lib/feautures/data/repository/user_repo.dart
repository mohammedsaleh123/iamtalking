import 'package:firebase_auth/firebase_auth.dart';
import 'package:iamtalking/core/services/services_locator.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';
import 'package:iamtalking/feautures/data/services/user_services.dart';

class UserRepo {
  UserRepo();

  UserServices userServices = sl<UserServices>();

  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<UserAuthModel> getCurrentUser() {
    return userServices.getCurrentUser().map(
          (user) => UserAuthModel.fromJson(user.data() as Map<String, dynamic>),
        );
  }

  Stream<UserAuthModel> getUser(String uid) {
    return userServices.getUser(uid).map(
          (user) => UserAuthModel.fromJson(user.data() as Map<String, dynamic>),
        );
  }

  Stream<List<UserAuthModel>> getAllUsers() {
    return userServices.getAllUsers().map((event) {
      return event.docs
          .map((e) => UserAuthModel.fromJson(e.data()))
          .toList()
          .where((user) => user.uid != auth.currentUser!.uid)
          .toList();
    });
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await userServices.updateUser(uid, data);
  }

  Future<void> deleteUser(String uid) async {
    await userServices.deleteUser(uid);
  }

  Future<void> followUser(String otherUserId) async {
    await userServices.followUser(otherUserId);
  }

  Future<void> unfollowUser(String otherUserId) async {
    await userServices.unfollowUser(otherUserId);
  }
}
