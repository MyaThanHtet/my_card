/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_card/ui/app_screen.dart';
import 'package:my_card/ui/navigation/navigation_cubit.dart';

Future main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),
      child: MaterialApp(
        themeMode: ThemeMode.dark, // Set the theme mode to dark
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColorDark: const Color(0xFF161F26),
          // Example color
        ),
        home: const AppScreen(),
      ),
    );
  }
}
