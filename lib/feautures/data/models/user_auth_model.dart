import 'package:cloud_firestore/cloud_firestore.dart';

class UserAuthModel {
  final String uid;
  final String userName;
  final String email;
  final String profileImage;
  final String imagePath;
  List? following;
  List? followers;
  List? savedChats;
  final Timestamp createdAt;

  UserAuthModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.profileImage,
    required this.imagePath,
    this.following,
    this.followers,
    this.savedChats,
    required this.createdAt,
  });

  factory UserAuthModel.fromJson(Map<String, dynamic> json) {
    return UserAuthModel(
      uid: json['uid'],
      userName: json['userName'],
      email: json['email'],
      profileImage: json['profileImage'],
      imagePath: json['imagePath'],
      following: json['following'],
      followers: json['followers'],
      savedChats: json['savedChats'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'profileImage': profileImage,
      'imagePath': imagePath,
      'following': following,
      'followers': followers,
      'savedChats': savedChats,
      'createdAt': createdAt,
    };
  }

  Future<UserAuthModel> fromFirestore(DocumentSnapshot snapshot) async {
    return UserAuthModel(
      uid: snapshot.get('uid'),
      userName: snapshot.get('userName'),
      email: snapshot.get('email'),
      profileImage: snapshot.get('profileImage'),
      imagePath: snapshot.get('imagePath'),
      following: snapshot.get('following'),
      followers: snapshot.get('followers'),
      savedChats: snapshot.get('savedChats'),
      createdAt: snapshot.get('createdAt'),
    );
  }
}
