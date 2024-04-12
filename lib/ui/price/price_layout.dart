import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_card/ui/price/bloc/price_bloc.dart';
import 'package:my_card/ui/price/widget/price_item.dart';

import '../../repository/post_service.dart';
import '../../repository/posts_repo.dart';

class PriceLayout extends StatefulWidget {
  const PriceLayout({super.key});

  @override
  State<PriceLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<PriceLayout> {
  late final PostsRepo postsRepo;
  late final PriceBloc priceBloc;

  @override
  void initState() {
    postsRepo = PostsRepo(service: PostService());
    priceBloc = PriceBloc(postsRepo: postsRepo);
    priceBloc.add(PriceInitialFetchEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<PriceBloc, PriceState>(
          listenWhen: (context, state) {
            return state is PriceInitial ||
                state is PriceFetchingLoadingState ||
                state is PriceFetchingSuccessfulState;
          },
          buildWhen: (context, state) {
            return state is PriceInitial ||
                state is PriceFetchingLoadingState ||
                state is PriceFetchingSuccessfulState;
          },
          listener: (BuildContext context, PriceState state) {},
          bloc: priceBloc,
          builder: (BuildContext context, PriceState state) {
            if (state is PriceFetchingLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PriceFetchingSuccessfulState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.priceList.length,
                      itemBuilder: (context, index) {
                        return PriceItem(
                          priceList: state.priceList[index],
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
