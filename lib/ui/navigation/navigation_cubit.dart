/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'nav_bar_items.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(NavbarItem.home, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(NavigationState(NavbarItem.home, 0));
        break;
      case NavbarItem.user:
        emit(NavigationState(NavbarItem.user, 1));
        break;
      case NavbarItem.price:
        emit(NavigationState(NavbarItem.price, 2));
        break;
    }
  }
}
