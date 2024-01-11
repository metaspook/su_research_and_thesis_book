import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/router/router.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';
import 'package:su_research_and_thesis_book/utils/extensions.dart';

class ThesisCarousel extends StatefulWidget {
  const ThesisCarousel({super.key});

  @override
  State<StatefulWidget> createState() => _ThesisCarouselState();
}

typedef PaperCarouselRecord = ({
  String title,
  String publisherName,
  String designation,
  String department,
  String description,
  void Function()? onTap
});

class _ThesisCarouselState extends State<ThesisCarousel> {
  final _controller = CarouselController();
  List<PaperCarouselRecord> _records = [];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final theses = context.select((ThesesCubit cubit) => cubit.state.theses);
    final researches =
        context.select((ResearchesCubit cubit) => cubit.state.researches);
    _records = [
      ...?theses?.map(
        (thesis) => (
          title: thesis.title.toStringParseNull(),
          publisherName: thesis.publisher!.name.toStringParseNull(),
          designation: thesis.publisher!.designation.toStringParseNull(),
          department: thesis.publisher!.department.toStringParseNull(),
          description: thesis.description.toStringParseNull(),
          onTap: () =>
              context.pushNamed(AppRouter.thesis.name!, extra: thesis.id),
        ),
      ),
      ...?researches?.map(
        (research) => (
          title: research.title.toStringParseNull(),
          publisherName: research.publisher!.name.toStringParseNull(),
          designation: research.publisher!.designation.toStringParseNull(),
          department: research.publisher!.department.toStringParseNull(),
          description: research.description.toStringParseNull(),
          onTap: () =>
              context.pushNamed(AppRouter.research.name!, extra: research.id),
        ),
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: _imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(milliseconds: 4500),
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            viewportFraction: .9,
            aspectRatio: context.mediaQuery.size.aspectRatio * 4,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 6; i++)
              GestureDetector(
                onTap: () => _controller.animateToPage(i),
                child: Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == i ? 0.9 : 0.4),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  List<Widget> get _imageSliders => [
        for (var i = 0; i < 6 - _records.length; i++)
          ColoredContainer(
            index: i,
            child: Center(
              child: Text(
                'Empty',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.mediaQuery.size.longestSide * .04,
                ),
              ),
            ),
          ),
        for (var i = 0; i < _records.length; i++)
          GestureDetector(
            onTap: _records[i].onTap,
            child: ColoredContainer(
              index: i,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _records[i].title,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.textTheme.titleMedium?.color
                          ?.withOpacity(.75),
                    ),
                  ),
                  Text(
                    _records[i].publisherName,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.textTheme.titleSmall?.color
                          ?.withOpacity(.5),
                    ),
                  ),
                  Text(
                    '${_records[i].designation} | ${_records[i].department}',
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.titleSmall?.copyWith(
                      color: context.theme.textTheme.titleSmall?.color
                          ?.withOpacity(.75),
                    ),
                  ),
                  Text(
                    _records[i].description,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.titleSmall?.copyWith(
                      color: context.theme.textTheme.titleSmall?.color
                          ?.withOpacity(.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ];
}

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({required this.index, super.key, this.child});

  final int index;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: AppThemes.width,
        vertical: AppThemes.height,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppThemes.selectedColorsRandomized[index],
          width: 2,
        ),
        borderRadius: AppThemes.borderRadius,
        boxShadow: [
          BoxShadow(
            color: AppThemes.selectedColorsRandomized[index].withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 1.75,
          ),
        ],
      ),
      child: child,
    );
  }
}

// Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color.fromARGB(0, 0, 0, 0),
//                     Color.fromARGB(150, 0, 0, 0),
//                   ],
//                 ),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'A New Cryptography',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Raifur Rahman',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 17.5,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Professor | Computer Science',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 15,
//                     ),
//                   ),
//                   Text(
//                     'A thesis, or dissertation, is a document submitted in support of candidature for an academic degree',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
