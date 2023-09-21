import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/comments/comments.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/extensions.dart';
import 'package:su_thesis_book/theme/theme.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // AppBar
          SliverAppBar(
            pinned: true,
            leading: context.backButton(),
            centerTitle: true,
            title: const Text('Comments'),
          ),
        ],
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(5),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 10,
              itemBuilder: (context, index) {
                final comment = Comment(
                  id: '2',
                  userId: 'profileImagePath',
                  thesisId: 'profileImagePath',
                  content: 'content',
                  createdAt: DateTime.now(),
                );
                return CommentCard(comment);
              },
            ),
            Card(
              color: context.theme.colorScheme.inversePrimary.withOpacity(.75),
              child: const Padding(
                padding: EdgeInsets.only(
                  bottom: 12,
                  left: 17.5,
                  right: 17.5,
                ),
                child: TextField(
                  clipBehavior: Clip.none,
                  decoration: InputDecoration(
                    hintText: 'comments here...',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
