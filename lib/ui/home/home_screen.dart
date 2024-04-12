/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_card/repository/post_service.dart';
import 'package:my_card/repository/posts_repo.dart';

import 'bloc/posts_bloc.dart';
import 'home_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => PostsRepo(service: PostService()),
        child: BlocProvider(
          create: (context) =>
              PostsBloc(postsRepo: RepositoryProvider.of<PostsRepo>(context)),
          child: const HomeLayout(),
        ),
      ),
    );
  }
}
