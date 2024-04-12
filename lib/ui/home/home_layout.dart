/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_card/ui/home/widgets/appbar_with_avatar.dart';
import 'package:my_card/ui/home/widgets/post_list_view.dart';

import '../../models/post_data_model.dart';
import '../../repository/post_service.dart';
import '../../repository/posts_repo.dart';
import 'bloc/posts_bloc.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late List<PostDataUiModel> posts;

  late final PostsRepo postsRepo;
  late final PostsBloc postsBloc;

  @override
  void initState() {
    posts = [];
    postsRepo = PostsRepo(service: PostService());
    postsBloc = PostsBloc(postsRepo: postsRepo);
    postsBloc.add(PostsInitialFetchEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithAvatar(),
      body: BlocConsumer<PostsBloc, PostsState>(
        listenWhen: (context, state) {
          return state is PostsInitial ||
              state is PostsFetchingLoadingState ||
              state is PostFetchingSuccessfulState ||
              state is PostsErrorState ||
              state is PostsDeletionSuccessState ||
              state is EditPostErrorState ||
              state is EditPostSuccessState ||
              state is AddPostSuccessState ||
              state is AddPostErrorState;
        },
        buildWhen: (context, state) {
          return state is PostsInitial ||
              state is PostsFetchingLoadingState ||
              state is PostFetchingSuccessfulState ||
              state is PostsErrorState ||
              state is PostsDeletionSuccessState ||
              state is EditPostErrorState ||
              state is EditPostSuccessState ||
              state is AddPostSuccessState ||
              state is AddPostErrorState;
        },
        bloc: postsBloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PostsFetchingLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostFetchingSuccessfulState) {
            posts = state.posts;
            return PostListView(
              posts: posts, onPostDeleted: (ostDataUiModel ) {
            },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
