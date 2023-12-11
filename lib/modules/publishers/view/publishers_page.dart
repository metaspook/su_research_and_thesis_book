import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/publishers/publishers.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef PublishersBlocSelector<T>
    = BlocSelector<PublishersCubit, PublishersState, T>;

class PublishersPage extends StatelessWidget {
  const PublishersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          context.sliverAppBar(
            context.l10n.publishersAppBarTitle,
            centerTitle: false,
          ),
        ],
        body: AppBlocSelector<List<Publisher>>(
          selector: (state) => state.publishers,
          builder: (context, publishers) {
            // Handle Null and Empty cases.
            return publishers.isEmpty
                ? const TranslucentLoader()
                : ListView.builder(
                    padding: AppThemes.viewPadding,
                    physics: const BouncingScrollPhysics(),
                    itemCount: publishers.length,
                    itemBuilder: (context, index) {
                      return PublisherCard(publishers[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
