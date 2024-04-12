import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_card/models/post_data_model.dart';
import 'package:my_card/ui/home/add_data_screen.dart';
import 'package:my_card/ui/home/edit_data_screen.dart';
import 'package:my_card/ui/home/widgets/post_item.dart';
import 'package:my_card/ui/home/widgets/post_list_view.dart';
import 'package:my_card/ui/home/widgets/tap_view.dart';

void main() {


  testWidgets('PostListView initial UI test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PostListView(
          posts: [],
          onPostDeleted: (PostDataUiModel) {},
        ),
      ),
    ));

    expect(find.text('API Translation'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(TapView), findsOneWidget);
  });

  testWidgets('PostListView add button test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PostListView(
          posts: [],
          onPostDeleted: (PostDataUiModel) {},
        ),
      ),
    ));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byType(AddDataScreen), findsOneWidget);
  });

  testWidgets('Edit post in PostListView widget test',
      (WidgetTester tester) async {
    final postData = PostDataUiModel(
      userId: 1,
      id: 1,
      title: 'Test Title',
      body: 'Test Body',
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PostListView(
          posts: [postData],
          onPostDeleted: (PostDataUiModel) {},
        ),
      ),
    ));

    expect(find.byType(PostItem), findsOneWidget);

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    expect(find.byType(EditDataScreen), findsOneWidget);
  });



}
