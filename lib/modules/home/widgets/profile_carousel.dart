import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/halo_avatar.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class ProfileCarousel extends StatefulWidget {
  const ProfileCarousel({required this.publishers, super.key});
  final List<Publisher> publishers;

  @override
  State<StatefulWidget> createState() => _ProfileCarouselState();
}

class _ProfileCarouselState extends State<ProfileCarousel> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
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
        for (final publisher in widget.publishers)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  HaloAvatar(publisher.photoUrl),
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

// final List<String> _imgList = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
// ];
