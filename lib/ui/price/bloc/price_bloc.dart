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

part 'price_event.dart';

part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  PriceBloc({
    required this.postsRepo,
  }) : super(PriceInitial()) {
    on<PriceInitialFetchEvent>(userInitialFetchEvent);
  }

  final PostsRepo postsRepo;

  FutureOr<void> userInitialFetchEvent(
      PriceInitialFetchEvent event, Emitter<PriceState> emit) async {
    emit(PriceFetchingLoadingState());
    List<PostDataUiModel> priceList = await postsRepo.fetchPosts();

    emit(PriceFetchingSuccessfulState(priceList: priceList));
  }
}
