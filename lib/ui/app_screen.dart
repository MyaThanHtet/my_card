/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/home_screen.dart';
import 'navigation/nav_bar_items.dart';
import 'navigation/navigation_cubit.dart';
import 'price/price_screen.dart';
import 'user/user_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            showUnselectedLabels: false,
            selectedItemColor: Colors.orange,
            // Color for selected icons
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard_rounded,
                ),
                label: 'User',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_rounded,
                ),
                label: 'Price',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.home);
              } else if (index == 1) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.user);
              } else if (index == 2) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.price);
              }
            },
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        if (state.navbarItem == NavbarItem.home) {
          return const HomeScreen();
        } else if (state.navbarItem == NavbarItem.user) {
          return const UserScreen();
        } else if (state.navbarItem == NavbarItem.price) {
          return const PriceScreen();
        }
        return Container();
      }),
    );
  }
}
