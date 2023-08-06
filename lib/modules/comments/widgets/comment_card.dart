import 'package:flutter/material.dart';
import 'package:su_thesis_book/shared/shared.dart';

class CommentCard extends StatelessWidget {
  const CommentCard(this.comment, {super.key});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.titleHeight,
        leading: const CircleAvatar(),
        title: Text(comment.author),
        subtitle: Text(comment.content),
      ),
    );
  }
}
