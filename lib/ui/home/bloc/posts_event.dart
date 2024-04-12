/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostsInitialFetchEvent extends PostsEvent {}

class AddPostEvent extends PostsEvent {
  final PostDataUiModel postData;

  AddPostEvent(this.postData);
}

class PostDeleteEvent extends PostsEvent {
  final int postId;

  PostDeleteEvent(this.postId);

  @override
  List<Object> get props => [postId];
}

class EditPostEvent extends PostsEvent {
  final PostDataUiModel editedPost;

  EditPostEvent(this.editedPost);

  @override
  List<Object> get props => [editedPost];
}
