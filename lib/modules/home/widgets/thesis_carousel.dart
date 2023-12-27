import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/extensions.dart';

class ThesisCarousel extends StatefulWidget {
  const ThesisCarousel({
    required this.theses,
    required this.researches,
    super.key,
  });
  final List<Thesis> theses;
  final List<Research> researches;

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
  final CarouselController _controller = CarouselController();
  late final List<PaperCarouselRecord> records;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    records = [
      for (var i = 0; i < 3; i++)
        (
          title: widget.theses[i].title.toStringParseNull(),
          publisherName: widget.theses[i].publisher!.name.toStringParseNull(),
          designation:
              widget.theses[i].publisher!.designation.toStringParseNull(),
          department:
              widget.theses[i].publisher!.department.toStringParseNull(),
          description: widget.theses[i].description.toStringParseNull(),
          onTap: () => context.pushNamed(
                AppRouter.thesis.name!,
                extra: widget.theses[i],
              ),
        ),
      for (var i = 0; i < 3; i++)
        (
          title: widget.researches[i].title.toStringParseNull(),
          publisherName:
              widget.researches[i].publisher!.name.toStringParseNull(),
          designation:
              widget.researches[i].publisher!.designation.toStringParseNull(),
          department:
              widget.researches[i].publisher!.department.toStringParseNull(),
          description: widget.researches[i].description.toStringParseNull(),
          onTap: () => context.pushNamed(
                AppRouter.thesis.name!,
                extra: widget.researches[i],
              ),
        ),
    ];
  }

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
        for (var i = 0; i < 6; i++)
          GestureDetector(
            onTap: records[i].onTap,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: AppThemes.width,
                vertical: AppThemes.height,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppThemes.selectedColorsRandomized[i],
                  width: 2,
                ),
                borderRadius: AppThemes.borderRadius,
                boxShadow: [
                  BoxShadow(
                    color:
                        AppThemes.selectedColorsRandomized[i].withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 1.75,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    records[i].title,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      color: AppThemes.selectedColorsRandomized[i],
                    ),
                    // style: const TextStyle(
                    //   color: Colors.white,
                    //   fontSize: 20,
                    //   fontWeight: FontWeight.bold,
                    // ),
                  ),
                  Text(
                    records[i].publisherName,
                    style: context.theme.textTheme.titleSmall,

                    //  const TextStyle(
                    //   color: Colors.white70,
                    //   fontSize: 17.5,
                    //   fontWeight: FontWeight.bold,
                    // ),
                  ),
                  Text(
                    '${records[i].designation} | ${records[i].department}',
                    style: context.theme.textTheme.titleSmall,
                    // style: const TextStyle(
                    //   color: Colors.white70,
                    //   fontSize: 15,
                    // ),
                  ),
                  Text(
                    records[i].description,
                    style: context.theme.textTheme.titleSmall,
                    maxLines: 2,
                    // style: const TextStyle(
                    //   color: Colors.white,
                    // ),
                  ),
                ],
              ),
            ),
          ),
      ];
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