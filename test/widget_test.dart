import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/components/PostView.dart';
import 'package:test_app/models/Post.dart';

main() {
  testWidgets("PostView should show content", (tester) async {

    var p = Post(id: 2,
        title: "title",
        userId: 3,
        content: "post content",
        likes: 4,
        hits: 55,
        categoryId: 1,
        imageUrl: "https://picsum.photos/seed/posts2/400/200");

    await tester.pumpWidget(MaterialApp(home: PostView(post: p, categoryName: "categoryName")));

    expect(find.text(p.content), findsOneWidget);
  });
}