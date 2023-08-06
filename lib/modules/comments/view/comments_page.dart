import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/comments/comments.dart';
import 'package:su_thesis_book/shared/shared.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final comment = Comment(
      author: 'author',
      profileImagePath: 'profileImagePath',
      content: 'content',
      createdAt: DateTime.now(),
    );
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CommentCard(comment),
        ],
      ),
    );
  }
}
