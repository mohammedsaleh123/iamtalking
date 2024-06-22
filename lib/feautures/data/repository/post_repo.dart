import 'package:iamtalking/core/services/services_locator.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:iamtalking/feautures/data/services/post_services.dart';

class PostRepo {
  final postServices = sl<PostServices>();
  Future<bool> addPost(Map<String, dynamic> data, String postId) async {
    return await postServices.addPost(data, postId);
  }

  Future<void> updatePost(
      String postId, String caption, String postImage) async {
    await postServices.updatePost(postId, caption, postImage);
  }

  Future<void> deletePost(String postId) async {
    await postServices.deletePost(postId);
  }

  Stream<List<PostModel>> getAllPosts() {
    return postServices.getPosts().snapshots().map((event) {
      return event.docs.map((e) => PostModel.fromJson(e.data())).toList();
    });
  }

  

  Future<void> likePost(String postId, List likes) async {
    await postServices.likePost(postId, likes);
  }

  Future<bool> savePost(PostModel post, String userId) async {
    return await postServices.savePost(post, userId);
  }

  Future<bool> unSavePost(PostModel post, String userId) async {
    return await postServices.unSavePost(post, userId);
  }
}
