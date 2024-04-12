/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/post_data_model.dart';
import '../../../repository/posts_repo.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc({
    required this.postsRepo,
  }) : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<AddPostEvent>(addPostEvent);
    on<PostDeleteEvent>(postDeleteEvent);
    on<EditPostEvent>(editPostEvent);
  }

  final PostsRepo postsRepo;

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());
    List<PostDataUiModel> posts = await postsRepo.fetchPosts();

    emit(PostFetchingSuccessfulState(posts: posts));
  }

  FutureOr<void> addPostEvent(
      AddPostEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());
    try {
      final success = await postsRepo.addPost(event.postData);
      if (success) {
        final posts = await postsRepo.fetchPosts();
        emit(AddPostSuccessState(addedPost: posts));
      } else {
        emit(PostsErrorState());
      }
    } catch (e) {
      emit(PostsErrorState());
    }
  }

  FutureOr<void> editPostEvent(
      EditPostEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());
    try {
      final success = await postsRepo.editPost(event.editedPost);
      if (success) {
        final posts = await postsRepo.fetchPosts();
        emit(PostFetchingSuccessfulState(posts: posts));
        emit(EditPostSuccessState(editedPost: event.editedPost));
      } else {
        emit(EditPostErrorState(errorMessage: 'Failed to edit post'));
      }
    } catch (e) {
      emit(EditPostErrorState(errorMessage: 'Failed to edit post'));
    }
  }

  FutureOr<void> postDeleteEvent(
      PostDeleteEvent event, Emitter<PostsState> emit) async {
    try {
      await postsRepo.deletePost(event.postId);
      List<PostDataUiModel> updatedPosts = await postsRepo.fetchPosts();

      emit(PostsDeletionSuccessState(posts: updatedPosts));
    } catch (error) {
      emit(PostsErrorState());
    }
  }
}
