import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String commentId;
  final String comment;
  final String userId;
  final String postId;
  final String userName;
  final String userImage;
  final Timestamp date;
  final List likes;
  String? commentImage;
  CommentModel({
    required this.commentId,
    required this.comment,
    required this.userId,
    required this.postId,
    required this.userName,
    required this.userImage,
    required this.date,
    required this.likes,
    this.commentImage
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentId': commentId,
      'comment': comment,
      'userId': userId,
      'postId': postId,
      'userName': userName,
      'userImage': userImage,
      'date': date,
      'likes': likes,
      'commentImage': commentImage,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['commentId'] as String,
      comment: map['comment'] as String,
      userId: map['userId'] as String,
      postId: map['postId'] as String,
      userName: map['userName'] as String,
      userImage: map['userImage'] as String,
      date: map['date'] as Timestamp,
      likes: List.from((map['likes'] as List),),
      commentImage: map['commentImage'] != null ? map['commentImage'] as String : null,
    );
  }

}
