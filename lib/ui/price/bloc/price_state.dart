/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

part of 'price_bloc.dart';

@immutable
abstract class PriceState {}

class PriceInitial extends PriceState {}

class PriceFetchingLoadingState extends PriceState {}

class PriceErrorState extends PriceState {}

class PriceFetchingSuccessfulState extends PriceState {
  final List<PostDataUiModel> priceList;

  PriceFetchingSuccessfulState({
    required this.priceList,
  });
}
