/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

part of 'price_bloc.dart';

@immutable
sealed class PriceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PriceInitialFetchEvent extends PriceEvent {}
