/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';

class AppBarWithAvatar extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/image.png'),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
