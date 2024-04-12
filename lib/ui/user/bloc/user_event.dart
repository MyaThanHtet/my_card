/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

part of 'user_bloc.dart';

@immutable
sealed class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitialFetchEvent extends UserEvent {}
