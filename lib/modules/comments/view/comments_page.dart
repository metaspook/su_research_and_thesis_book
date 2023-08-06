import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/comments/comments.dart';
import 'package:su_thesis_book/shared/shared.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Comments')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(5),
              itemCount: 10,
              itemBuilder: (context, index) {
                final comment = Comment(
                  author: 'author',
                  profileImagePath: 'profileImagePath',
                  content: 'content',
                  createdAt: DateTime.now(),
                );
                return CommentCard(comment);
              },
            ),
          ),
          const TextField()
        ],
      ),
    );
  }
}
