import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/shared/widgets/halo_avatar.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

class ProfileCarousel extends StatefulWidget {
  const ProfileCarousel({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileCarouselState();
}

class _ProfileCarouselState extends State<ProfileCarousel> {
  final CarouselController _controller = CarouselController();
  List<Publisher> _publishers = [];

  @override
  Widget build(BuildContext context) {
    final thesisPublishers =
        context.select((ThesesCubit cubit) => cubit.state.publishers);
    final researchPublishers =
        context.select((ResearchesCubit cubit) => cubit.state.publishers);
    _publishers = [
      ...{...?thesisPublishers, ...?researchPublishers},
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: _imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
            aspectRatio: context.mediaQuery.size.aspectRatio * 6,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            reverse: true,
            // viewportFraction: .3,
            viewportFraction: .265,
            // height: context.mediaQuery.size.height * .175,
          ),
        ),
      ],
    );
  }

  List<Widget> get _imageSliders => [
        for (var i = 0; i < 6 - _publishers.length; i++)
          // Placeholders if publishers less then 6
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const HaloAvatar(),
                  const SizedBox(height: AppThemes.height),
                  Text(
                    'Designation',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.labelMedium
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                  Text(
                    'Publisher Name',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Department',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        for (final publisher in _publishers)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  HaloAvatar(url: publisher.photoUrl),
                  const SizedBox(height: AppThemes.height),
                  Text(
                    publisher.designation.toStringParseNull(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.labelMedium
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                  Text(
                    publisher.name.toStringParseNull(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    publisher.department.toStringParseNull(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
      ];
}
