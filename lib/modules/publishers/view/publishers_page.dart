import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/l10n/l10n.dart';
import 'package:su_research_and_thesis_book/modules/publishers/publishers.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';

class PublishersPage extends StatelessWidget {
  const PublishersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          context.sliverAppBar(context.l10n.publishersAppBarTitle),
        ],
        body: Builder(
          builder: (context) {
            final thesisPublishers =
                context.select((ThesesCubit cubit) => cubit.state.publishers);
            final researchPublishers = context
                .select((ResearchesCubit cubit) => cubit.state.publishers);
            final publishers =
                thesisPublishers == null && researchPublishers == null
                    ? null
                    : {
                        ...?thesisPublishers,
                        ...?researchPublishers,
                      };

            return publishers == null
                ? const TranslucentLoader()
                : publishers.isEmpty
                    ? context.emptyListText()
                    : ListView.builder(
                        padding: AppThemes.viewPadding,
                        physics: const BouncingScrollPhysics(),
                        itemCount: publishers.length,
                        itemBuilder: (context, index) {
                          return PublisherCard(publishers.elementAt(index));
                        },
                      );
          },
        ),
      ),
    );
  }
}
