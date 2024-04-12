/*
 * Mya Than Htet
 * Copyright (c) 2024.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_data_model.dart';
import '../../repository/post_service.dart';
import '../../repository/posts_repo.dart';
import 'bloc/posts_bloc.dart';

class AddDataScreen extends StatefulWidget {
  final void Function(List<PostDataUiModel>) onAddSuccess;

  const AddDataScreen({Key? key, required this.onAddSuccess}) : super(key: key);

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  late final PostsRepo postsRepo;
  late final PostsBloc postsBloc;
  late List<PostDataUiModel> posts;

  @override
  void initState() {
    posts = [];
    postsRepo = PostsRepo(service: PostService());
    postsBloc = PostsBloc(postsRepo: postsRepo);
    postsBloc.add(PostsInitialFetchEvent());

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
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: BlocProvider(
            create: (context) => postsBloc,
            child: BlocConsumer<PostsBloc, PostsState>(
              listenWhen: (context, state) {
                return state is PostsInitial ||
                    state is PostsFetchingLoadingState ||
                    state is PostFetchingSuccessfulState ||
                    state is PostsErrorState ||
                    state is AddPostSuccessState ||
                    state is AddPostErrorState;
              },
              buildWhen: (context, state) {
                return state is PostsInitial ||
                    state is PostsFetchingLoadingState ||
                    state is PostFetchingSuccessfulState ||
                    state is PostsErrorState ||
                    state is AddPostSuccessState ||
                    state is AddPostErrorState;
              },
              listener: (context, state) {
                if (state is AddPostSuccessState) {
                  final newPost = _convertToPostData(_formData);
                  widget.onAddSuccess([newPost]);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data submitted successfully'),
                    ),
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
                        child: Text(
                          "Add API",
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
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
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: screenWidth * 0.04),
                              decoration: BoxDecoration(
                                color: const Color(0xFF05090D),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'User ID',
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    // Allow only digits
                                  ],
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
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: screenWidth * 0.04),
                              decoration: BoxDecoration(
                                color: const Color(0xFF05090D),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'ID',
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    // Allow only digits
                                  ],
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
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: screenWidth * 0.04),
                              decoration: BoxDecoration(
                                color: const Color(0xFF05090D),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                                child: TextFormField(
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
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: screenWidth * 0.04),
                              decoration: BoxDecoration(
                                color: const Color(0xFF05090D),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                                child: TextFormField(
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
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    widget.onAddSuccess(posts);

                                    BlocProvider.of<PostsBloc>(context).add(
                                      AddPostEvent(
                                          _convertToPostData(_formData)),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  fixedSize: Size(
                                      screenWidth * 0.6, screenWidth * 0.12),
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
