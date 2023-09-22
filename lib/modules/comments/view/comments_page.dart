import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/comments/comments.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({required this.thesis, super.key});

  final Thesis thesis;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CommentsCubit>();
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
            Builder(
              builder: (context) {
                final isLoading = context.select(
                  (CommentsCubit cubit) => cubit.state.status.isLoading,
                );
                final comments = context
                    .select((CommentsCubit cubit) => cubit.state.comments);

                return comments.isEmpty
                    ? Center(
                        child: Text(
                          'No Comments!',
                          style: context.theme.textTheme.displayMedium,
                        ),
                      )
                    : TranslucentLoader(
                        enabled: false,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(5),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return CommentCard(comments[index]);
                          },
                        ),
                      );
              },
            ),
            Card(
              color: context.theme.colorScheme.inversePrimary.withOpacity(.75),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                  left: 17.5,
                  right: 17.5,
                ),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  clipBehavior: Clip.none,
                  onChanged: cubit.onChangedCommentText,
                  decoration: InputDecoration(
                    hintText: 'comment here...',
                    suffixIcon: Builder(
                      builder: (context) {
                        final userId = context.select(
                          (AppCubit cubit) => cubit.state.user.id,
                        );
                        final enabled = context.select(
                          (CommentsCubit cubit) =>
                              cubit.state.commentText.isNotEmpty,
                        );

                        return IconButton(
                          onPressed: enabled
                              ? () => cubit.send(
                                    userId: userId,
                                    thesisId: thesis.id,
                                  )
                              : null,
                          icon: const Icon(Icons.send_rounded),
                        );
                      },
                    ),
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
