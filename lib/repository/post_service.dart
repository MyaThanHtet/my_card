/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/post_data_model.dart';

class PostService {
  PostService({
    http.Client? httpClient,
    this.baseUrl = 'https://jsonplaceholder.typicode.com',
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final Client _httpClient;

  Future<List<PostDataUiModel>> fetchPosts() async {
    List<PostDataUiModel> posts = [];
    try {
      var response = await _httpClient.get(Uri.parse('$baseUrl/posts'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post =
            PostDataUiModel.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }

      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<bool> addPost(PostDataUiModel postData) async {
    try {
      var response = await _httpClient.post(
        Uri.parse('$baseUrl/posts'),
        body: jsonEncode({
          "title": postData.title,
          "body": postData.body,
          "userId": postData.userId,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePost(int postId) async {
    try {
      var response = await _httpClient.delete(
        Uri.parse('$baseUrl/posts/$postId'),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true; // Post deleted successfully
      } else {
        return false; // Failed to delete post
      }
    } catch (e) {
      log(e.toString());
      return false; // Error occurred while deleting post
    }
  }

  Future<bool> editPost(int postId, PostDataUiModel updatedPost) async {
    try {
      var response = await _httpClient.put(
        Uri.parse('$baseUrl/posts/$postId'),
        body: updatedPost.toJson(),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true; // Post edited successfully
      } else {
        return false; // Failed to edit post
      }
    } catch (e) {
      log(e.toString());
      return false; // Error occurred while editing post
    }
  }
}
