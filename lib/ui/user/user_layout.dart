/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_card/ui/user/widget/user_item.dart';

import '../../models/post_data_model.dart';
import '../../repository/post_service.dart';
import '../../repository/posts_repo.dart';
import 'bloc/user_bloc.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  late final PostsRepo postsRepo;
  late final UserBloc userBloc;
  late List<PostDataUiModel> users;

  @override
  void initState() {
    users = [];
    postsRepo = PostsRepo(service: PostService());
    userBloc = UserBloc(postsRepo: postsRepo);
    userBloc.add(UserInitialFetchEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<UserBloc, UserState>(
          listenWhen: (context, state) {
            return state is UserInitial ||
                state is UserFetchingLoadingState ||
                state is UserFetchingSuccessfulState;
          },
          buildWhen: (context, state) {
            return state is UserInitial ||
                state is UserFetchingLoadingState ||
                state is UserFetchingSuccessfulState;
          },
          listener: (BuildContext context, UserState state) {},
          bloc: userBloc,
          builder: (BuildContext context, UserState state) {
            if (state is UserFetchingLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserFetchingSuccessfulState) {
              users = state.users;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'SUM API',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final post = users[index];
                        return UserItem(
                          user: post,
                          onDelete: () {},
                          onEdit: () {},
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
