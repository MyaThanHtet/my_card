/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_card/ui/home/widgets/post_item.dart';
import 'package:my_card/ui/home/widgets/tap_view.dart';

import '../../../models/post_data_model.dart';
import '../add_data_screen.dart';
import '../bloc/posts_bloc.dart';
import '../edit_data_screen.dart';

class PostListView extends StatefulWidget {
  final List<PostDataUiModel> posts;
  final void Function(PostDataUiModel) onPostDeleted;

    PostListView({super.key, required this.posts, required this.onPostDeleted});

  @override
  _PostListViewState createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  late List<PostDataUiModel> _posts;
  late List<PostDataUiModel> _filteredPosts;
  String _filterText = '';

  @override
  void initState() {
    super.initState();
    _posts = List.from(widget.posts); // Make a copy of the initial posts list
    _filteredPosts =
        List.from(widget.posts); // Initialize filtered posts with all posts
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Text(
              'API Translation',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _filterText = value;
                  _filterPosts();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFF262626),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          TapView(
            onAdd: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddDataScreen(
                    onAddSuccess: (List<PostDataUiModel> addedPosts) {
                      for (var post in addedPosts) {
                        _addPost(post);
                      }
                    },
                  ),
                ),
              );
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filteredPosts.length,
            itemBuilder: (context, index) {
              final post = _filteredPosts[index];
              return PostItem(
                post: post,
                onDelete: () {
                  // Call the delete function
                  _showAlertDialog(post);
                },
                onEdit: () {
                  _editPost(post);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _deletePost(PostDataUiModel post) {
    setState(() {
      // Remove the post from the lists
      _posts.remove(post);
      _filteredPosts.remove(post);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data deleted successfully')),
      );
      Navigator.of(context).pop();
    });

    BlocProvider.of<PostsBloc>(context).add(PostDeleteEvent(post.id));
  }

  void _editPost(PostDataUiModel postDataUiModel) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditDataScreen(
          postDataUiModel: postDataUiModel,
          onPostEdited: (PostDataUiModel posts) {
            _updatePostInList(posts);
          },
        ),
      ),
    );
  }

  void _updatePostInList(PostDataUiModel updatedPost) {
    setState(() {
      final index =
          _filteredPosts.indexWhere((post) => post.id == updatedPost.id);
      if (index != -1) {
        _filteredPosts[index] = updatedPost;
      }
    });
  }

  void _showAlertDialog(PostDataUiModel post) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Delete API')),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  _deletePost(post);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _addPost(PostDataUiModel newPost) {
    setState(() {
      //_posts.add(newPost);
      _posts.insert(
          0, newPost); // Add the new post to the beginning of the list
      _filterPosts(); // Update the filtered posts list
    });
  }

  void _filterPosts() {
    if (_filterText.isEmpty) {
      // If the filter text is empty, display all posts
      setState(() {
        _filteredPosts = List.from(_posts);
      });
    } else {
      // Filter the posts based on the search text
      setState(() {
        _filteredPosts = _posts
            .where((post) =>
                post.title.toLowerCase().contains(_filterText.toLowerCase()))
            .toList();
      });
    }
  }
}
