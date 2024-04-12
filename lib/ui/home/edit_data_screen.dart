/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_data_model.dart';
import '../../repository/post_service.dart';
import '../../repository/posts_repo.dart';
import 'bloc/posts_bloc.dart';

class EditDataScreen extends StatefulWidget {
  final PostDataUiModel postDataUiModel;
  final Function(PostDataUiModel) onPostEdited; // Callback function

  const EditDataScreen({
    super.key,
    required this.postDataUiModel,
    required this.onPostEdited,
  });

  @override
  _EditDataScreenState createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  late PostDataUiModel _editedPostData;
  late final PostsRepo postsRepo;
  late final PostsBloc postsBloc;
  late List<PostDataUiModel> posts;

  @override
  void initState() {
    posts = [];
    postsRepo = PostsRepo(service: PostService());
    postsBloc = PostsBloc(postsRepo: postsRepo);
    postsBloc.add(PostsInitialFetchEvent());
    _editedPostData = widget.postDataUiModel;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'userId': '',
    'id': '',
    'title': '',
    'body': '',
  };

  PostDataUiModel _convertToPostData(Map<String, dynamic> formData) {
    return PostDataUiModel(
      userId: formData['userId'],
      id: formData['id'],
      title: formData['title'],
      body: formData['body'],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
          child: BlocProvider(
            create: (context) => postsBloc,
            child: BlocConsumer<PostsBloc, PostsState>(
              listenWhen: (context, state) {
                return state is PostsInitial ||
                    state is PostsFetchingLoadingState ||
                    state is PostFetchingSuccessfulState ||
                    state is PostsErrorState ||
                    state is PostsDeletionSuccessState ||
                    state is EditPostErrorState ||
                    state is EditPostSuccessState ||
                    state is AddPostSuccessState ||
                    state is AddPostErrorState;
              },
              buildWhen: (context, state) {
                return state is PostsInitial ||
                    state is PostsFetchingLoadingState ||
                    state is PostFetchingSuccessfulState ||
                    state is PostsErrorState ||
                    state is PostsDeletionSuccessState ||
                    state is EditPostErrorState ||
                    state is EditPostSuccessState ||
                    state is AddPostSuccessState ||
                    state is AddPostErrorState;
              },
              listener: (context, state) {
                if (state is EditPostSuccessState) {
                  widget.onPostEdited(_convertToPostData(_formData));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data Edited successfully')),
                  );
                  Navigator.pop(context);
                } else if (state is EditPostErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );

                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: screenWidth * 0.03),
                        // Responsive padding
                        child: Text(
                          "Edit API",
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            // Responsive font size
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenWidth * 0.04),
                            // Responsive spacing
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: screenWidth * 0.04),
                              // Responsive margin
                              decoration: BoxDecoration(
                                color: const Color(0xFF05090D),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                                // Responsive padding
                                child: TextFormField(
                                  initialValue:
                                      widget.postDataUiModel.userId.toString(),
                                  decoration: const InputDecoration(
                                    labelText: 'User ID',
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a user ID';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) =>
                                      _formData['userId'] = int.parse(value!),
                                ),
                              ),
                            ),
                            SizedBox(height: screenWidth * 0.04),
                            // Responsive spacing
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: screenWidth * 0.04),
                              // Responsive margin
                              decoration: BoxDecoration(
                                color: const Color(0xFF05090D),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                                // Responsive padding
                                child: TextFormField(
                                  initialValue:
                                      widget.postDataUiModel.id.toString(),
                                  decoration: const InputDecoration(
                                    labelText: 'ID',
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an ID';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) =>
                                      _formData['id'] = int.parse(value!),
                                ),
                              ),
                            ),
                            SizedBox(height: screenWidth * 0.04),
                            // Responsive spacing
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: screenWidth * 0.04),
                              // Responsive margin
                              decoration: BoxDecoration(
                                color: const Color(0xFF05090D),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                                // Responsive padding
                                child: TextFormField(
                                  initialValue: widget.postDataUiModel.title,
                                  decoration: const InputDecoration(
                                    labelText: 'Title',
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a title';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) =>
                                      _formData['title'] = value!,
                                ),
                              ),
                            ),
                            SizedBox(height: screenWidth * 0.04),
                            // Responsive spacing
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: screenWidth * 0.04),
                              // Responsive margin
                              decoration: BoxDecoration(
                                color: const Color(0xFF05090D),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                                // Responsive padding
                                child: TextFormField(
                                  initialValue: widget.postDataUiModel.body,
                                  decoration: const InputDecoration(
                                    labelText: 'Body',
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a body';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) =>
                                      _formData['body'] = value!,
                                ),
                              ),
                            ),
                            SizedBox(height: screenWidth * 0.08),
                            // Responsive spacing
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    BlocProvider.of<PostsBloc>(context).add(
                                        EditPostEvent(
                                            _convertToPostData(_formData)));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  fixedSize: Size(
                                      screenWidth * 0.6,
                                      screenWidth *
                                          0.12), // Responsive button size
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
//Mya Than Htet
