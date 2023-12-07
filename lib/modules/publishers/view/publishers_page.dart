import 'package:cache/cache.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class PublishersPage extends StatelessWidget {
  const PublishersPage({super.key});

  @override
  Widget build(BuildContext context) {
    const cache = Cache<List<Thesis>>('theses');
    cache.value.doPrint('Cache: ');
    FirebaseDatabase.instance
        .ref('theses')
        // .child('ownerId')
        // .equalTo('ownerId')
        // .orderByKey()
        .get()
        .then((value) => print('GO: $value'));

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          context.sliverAppBar(
            context.l10n.publishersAppBarTitle,
            centerTitle: false,
          ),
        ],
        body: ListView.builder(
          padding: AppThemes.viewPadding,
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            // final thesis = theses[index];
            return const Text('HEllo');
          },
        ),
      ),
    );
  }
}
