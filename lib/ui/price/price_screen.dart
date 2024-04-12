/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_card/ui/price/price_layout.dart';

import '../../repository/post_service.dart';
import '../../repository/posts_repo.dart';
import 'bloc/price_bloc.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => PostsRepo(service: PostService()),
        child: BlocProvider(
            create: (context) =>
                PriceBloc(postsRepo: RepositoryProvider.of<PostsRepo>(context)),
            child: const PriceLayout()),
      ),
    );
  }
}
