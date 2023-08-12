import 'package:flutter/material.dart';
import 'package:su_thesis_book/shared/extensions/extensions.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

class CommentCard extends StatelessWidget {
  const CommentCard(this.comment, {super.key});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.titleHeight,
        leading: HaloAvatar(haloAccent: context.theme.colorScheme.primary),
        title: const Text('author'),
        subtitle: Text(comment.body),
      ),
    );
  }
}
