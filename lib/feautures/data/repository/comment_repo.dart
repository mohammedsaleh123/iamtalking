import 'package:iamtalking/feautures/data/models/comment_model.dart';
import 'package:iamtalking/feautures/data/services/comment_services.dart';

import '../../../core/services/services_locator.dart';

class CommentRepo {
  final commentServices = sl<CommentServices>();

  Future<void> addComment(String postId,String commentId, Map<String, dynamic> data) async {
    await commentServices.addComment(postId,commentId, data);
  }

  Future<void> deleteComment(String postId, String commentId) async {
    await commentServices.deleteComment(postId, commentId);
  }

  Future<void> updateComment(
      String postId, String commentId, Map<String, dynamic> data) async {
    await commentServices.updateComment(postId, commentId, data);
  }

  Future<void> likeComment(String postId, String commentId) async {
    await commentServices.likeComment(postId, commentId);
  }

  Future<void> unlikeComment(String postId, String commentId) async {
    await commentServices.unLikeComment(postId, commentId);
  }

  Stream<List<CommentModel>> getComments(String postId) {
    return commentServices.getComments(postId).snapshots().map((event) =>
        event.docs.map((comment) => CommentModel.fromMap(comment.data())).toList());
  }
}
