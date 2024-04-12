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

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required this.postsRepo,
  }) : super(UserInitial()) {
    on<UserInitialFetchEvent>(userInitialFetchEvent);
  }

  final PostsRepo postsRepo;

  FutureOr<void> userInitialFetchEvent(
      UserInitialFetchEvent event, Emitter<UserState> emit) async {
    emit(UserFetchingLoadingState());
    List<PostDataUiModel> users = await postsRepo.fetchPosts();

    emit(UserFetchingSuccessfulState(users: users));
  }
}
