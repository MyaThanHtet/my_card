/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';

class TapView extends StatelessWidget {
  final VoidCallback? onAdd;

  const TapView({
    super.key,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'All',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            const Text(
              'API',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const Text(
              'API',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(),
            IconButton(
              onPressed: onAdd,
              icon: const Icon(
                Icons.add,
                color: Colors.orange,
              ),
            ),
          ],
        ));
  }
}
