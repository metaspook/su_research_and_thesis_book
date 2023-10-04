import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/models/models.dart';

class BookmarkView extends StatelessWidget {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    const thesis = Thesis(id: 'id', userId: 'userId');
    return Scaffold(
      body: ListView(
        children: [
          for (var i = 0; i < 10; i++) const ThesisCard(thesis),
        ],
      ),
    );
  }
}
