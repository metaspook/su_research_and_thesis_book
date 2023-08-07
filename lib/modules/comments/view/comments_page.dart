import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/comments/comments.dart';
import 'package:su_thesis_book/shared/shared.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Mod.backButton(context),
        centerTitle: true,
        title: const Text('Comments'),
      ),
      body: ListView.builder(
        // shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(5),
        itemCount: 20 + 1,
        itemBuilder: (context, index) {
          final comment = Comment(
            author: 'author',
            profileImagePath: 'profileImagePath',
            content: 'content',
            createdAt: DateTime.now(),
          );
          return index == 0
              ? Container(height: kToolbarHeight * 1.4)
              : CommentCard(comment);
        },
      ),
    );
  }
}
  //  ClipRRect(
  //           borderRadius: const BorderRadius.only(
  //             topRight: Radius.circular(24),
  //             topLeft: Radius.circular(24),
  //           ),
  //           child: Card(
  //             color: context.theme.colorScheme.inversePrimary.withOpacity(.75),
  //             child: const Padding(
  //               padding: EdgeInsets.only(bottom: 12, left: 17.5, right: 17.5),
  //               child: TextField(),
  //             ),
  //           ),
  //         ),