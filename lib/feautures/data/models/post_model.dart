import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? caption;
  final String postId;
  String userId;
  String userName;
  String userImage;
  final String postImage;
  String? postVideo;
  String imagePath;
  final List<String> likes;
  final List<String> savedPost;
  final Timestamp createdAt;

  PostModel({
    this.caption,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.postImage,
    this.postVideo,
    required this.imagePath,
    required this.likes,
    required this.savedPost,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      caption: json['caption'],
      postId: json['postId'],
      userId: json['userId'],
      userName: json['userName'],
      userImage: json['userImage'],
      postImage: json['postImage'],
      postVideo: json['postVideo'],
      imagePath: json['imagePath'],
      likes: List<String>.from(json['likes']),
      savedPost: List<String>.from(json['savedPost']),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'postId': postId,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'postImage': postImage,
      'postVideo': postVideo,
      'imagePath': imagePath,
      'likes': likes,
      'savedPost': savedPost,
      'createdAt': createdAt,
    };
  }

  Stream<PostModel> fromFirestore(DocumentSnapshot snapshot) {
    return snapshot.reference.snapshots().map((post) {
      return PostModel.fromJson(post.data() as Map<String, dynamic>);
    });
  }
}
