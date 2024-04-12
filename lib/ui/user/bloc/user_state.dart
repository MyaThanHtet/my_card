/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserFetchingLoadingState extends UserState {}

class UserErrorState extends UserState {}

class UserFetchingSuccessfulState extends UserState {
  final List<PostDataUiModel> users;

  UserFetchingSuccessfulState({
    required this.users,
  });
}
