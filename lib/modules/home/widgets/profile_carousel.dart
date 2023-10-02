import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:su_thesis_book/shared/widgets/halo_avatar.dart';
import 'package:su_thesis_book/theme/theme.dart';

class ProfileCarousel extends StatefulWidget {
  const ProfileCarousel({super.key});

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
            autoPlay: true,
            // enlargeCenterPage: true,
            aspectRatio: 2.5,
            // aspectRatio: context.mediaQuery.size.width * .00675,
            viewportFraction: .3,
            // viewportFraction: context.mediaQuery.size.width * .0008,
          ),
        ),
      ],
    );
  }
}

final List<String> _imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
];
final List<Widget> _imageSliders = [
  ..._imgList.map(
    (e) => Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HaloAvatar(e),
            const SizedBox(height: AppThemes.height),
            const Text(
              'Professor',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const Text(
              'Raifur Rahman',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              'Computer Science',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  ),
];
