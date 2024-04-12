/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:my_card/repository/post_service.dart';

import '../models/post_data_model.dart';

class PostsRepo {
  const PostsRepo({
    required this.service,
  });

  final PostService service;

  Future<List<PostDataUiModel>> fetchPosts() async => service.fetchPosts();

  Future<bool> addPost(PostDataUiModel post) async {
    try {
      // Call the addPost method from the service
      final success = await service.addPost(post);

      // Return the result from the service
      return success;
    } catch (e) {
      // Handle any errors that occur during the process
      return false;
    }
  }

  Future<bool> editPost(PostDataUiModel editedPost) async {
    try {
      final success = await service.editPost(editedPost.id, editedPost);
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePost(int postId) async {
    // Perform the delete operation using the service
    try {
      await service.deletePost(postId);
      // Return true if deletion was successful
      return true;
    } catch (e) {
      return false;
    }
  }
}
