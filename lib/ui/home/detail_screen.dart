/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';

import '../../models/post_data_model.dart';

class PostDetailScreen extends StatelessWidget {
  final PostDataUiModel post;

  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double avatarSize = MediaQuery.of(context).size.width * 0.2;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: CircleAvatar(
                      radius: avatarSize,
                      backgroundImage: const AssetImage('assets/image.png'),
                    ),
                  ),
                  SizedBox(
                    height: screenWidth * 0.05,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: const Color(0xFF080C0C),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Post Detail',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02,
                                  vertical: screenHeight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF111313),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'User ID: ${post.id}',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: Text(
                            'Title: ${post.title}',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.05),
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: Text(
                            'Body: ${post.body}',
                            style: TextStyle(fontSize: screenWidth * 0.04),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: Text(
                            'Price:',
                            style: TextStyle(fontSize: screenWidth * 0.04),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.25,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02,
                                  vertical: screenHeight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF111313),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '100\$',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.25,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02,
                                  vertical: screenHeight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF111313),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '200\$',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.25,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02,
                                  vertical: screenHeight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF111313),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '300\$',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
