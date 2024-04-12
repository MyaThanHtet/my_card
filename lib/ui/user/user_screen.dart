/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_card/ui/user/bloc/user_bloc.dart';
import 'package:my_card/ui/user/user_layout.dart';

import '../../repository/post_service.dart';
import '../../repository/posts_repo.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => PostsRepo(service: PostService()),
        child: BlocProvider(
            create: (context) =>
                UserBloc(postsRepo: RepositoryProvider.of<PostsRepo>(context)),
            child: const UserLayout()),
      ),
    );
  }
} /**/
