/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsFetchingLoadingState extends PostsState {}

class PostsErrorState extends PostsState {}

class PostFetchingSuccessfulState extends PostsState {
  final List<PostDataUiModel> posts;

  PostFetchingSuccessfulState({
    required this.posts,
  });
}

class PostsDeletionSuccessState extends PostsState {
  final List<PostDataUiModel> posts;

  PostsDeletionSuccessState({required this.posts});

  List<Object> get props => [posts];
}

class EditPostSuccessState extends PostsState {
  final PostDataUiModel editedPost;

  EditPostSuccessState({required this.editedPost});
}

class EditPostErrorState extends PostsState {
  final String errorMessage;

  EditPostErrorState({required this.errorMessage});
}

class AddPostSuccessState extends PostsState {
  final List<PostDataUiModel> addedPost;

  AddPostSuccessState({required this.addedPost});
}

class AddPostErrorState extends PostsState {
  final String errorMessage;

  AddPostErrorState({required this.errorMessage});
}
