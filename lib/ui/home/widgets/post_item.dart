/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';

import '../../../models/post_data_model.dart';
import '../detail_screen.dart';

class PostItem extends StatelessWidget {
  final PostDataUiModel post;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const PostItem({
    super.key,
    required this.post,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    double avatarSize = MediaQuery.of(context).size.width *
        0.08; // Adjust avatar size based on screen width
    double titleFontSize = MediaQuery.of(context).size.width *
        0.045; // Adjust font size based on screen width
    double bodyFontSize = MediaQuery.of(context).size.width *
        0.04; // Adjust font size based on screen width

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(post: post),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF161F26), Color(0xFF05090D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: avatarSize,
                backgroundImage: const AssetImage('assets/image.png'),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post.body,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: bodyFontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
