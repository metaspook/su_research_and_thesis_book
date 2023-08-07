import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/comments/comments.dart';
import 'package:su_thesis_book/shared/shared.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            leading: Mod.backButton(context),
            centerTitle: true,
            title: const Text('Comments'),
          )
        ],
        body: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(5),
          itemCount: 20,
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
    );
  }
}


//  Column(
//             children: [
//               const Spacer(),
//               Card(
//                 color:
//                     context.theme.colorScheme.inversePrimary.withOpacity(.75),
//                 margin:
//                     const EdgeInsets.only(bottom: 315, left: 17.5, right: 17.5),
//                 child: const Padding(
//                   padding: EdgeInsets.only(bottom: 12, left: 17.5, right: 17.5),
//                   child: TextField(
//                     decoration: InputDecoration(hintText: 'Comment here...'),
//                   ),
//                 ),
//               ),
//             ],
//           ),