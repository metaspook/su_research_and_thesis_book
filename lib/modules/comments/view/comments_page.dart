import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/comments/comments.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({required this.thesis, super.key});

  final Thesis thesis;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  // TextEditingControllers & FocusNodes
  final _commentController = TextEditingController();
  final _commentFocusNode = FocusNode();

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

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
                        enabled: isLoading,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(5),
                          // keyboardDismissBehavior:
                          //     ScrollViewKeyboardDismissBehavior.onDrag,
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
                  controller: _commentController,
                  focusNode: _commentFocusNode,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  clipBehavior: Clip.none,
                  decoration: InputDecoration(
                    hintText: 'comment here...',
                    suffixIcon: AppBlocSelector<String>(
                      selector: (state) => state.user.id,
                      builder: (context, userId) {
                        return IconButton(
                          onPressed: () {
                            _commentFocusNode.unfocus();
                            if (_commentController.text.isNotEmpty) {
                              cubit.send(
                                userId: userId,
                                thesisId: widget.thesis.id,
                                commentStr: _commentController.text,
                              );
                              _commentController.clear();
                            }
                          },
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
