import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/extensions.dart';

class CommentCard extends StatelessWidget {
  const CommentCard(this.comment, {super.key});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.titleHeight,
        leading: CircleAvatar(
          backgroundImage: comment.authorPhotoUrl == null
              ? null
              : CachedNetworkImageProvider(comment.authorPhotoUrl!),
        ),
        title: Text(comment.author.toStringParseNull()),
        subtitle: Text(comment.content.toStringParseNull()),
      ),
    );
  }
}
