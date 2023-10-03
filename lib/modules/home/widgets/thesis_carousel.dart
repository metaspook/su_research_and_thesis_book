import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:su_thesis_book/theme/theme.dart';

class ThesisCarousel extends StatefulWidget {
  const ThesisCarousel({super.key});

  @override
  State<StatefulWidget> createState() => _ThesisCarouselState();
}

class _ThesisCarouselState extends State<ThesisCarousel> {
  int _current = 0;
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
            enlargeCenterPage: true,
            // aspectRatio: 1.5,
            viewportFraction: .9,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            autoPlayInterval: const Duration(milliseconds: 4500),
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
}

final List<Widget> _imageSliders = [
  for (var i = 0; i < 6; i++)
    Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: AppThemes.width,
        vertical: AppThemes.height,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppThemes.selectedColorsRandomized[i],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppThemes.selectedColorsRandomized[i].withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 1.75,
          ),
        ],
      ),
      child: const Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A New Cryptography',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Raifur Rahman',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 17.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Professor | Computer Science',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
              Text(
                'A thesis, or dissertation, is a document submitted in support of candidature for an academic degree',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
];

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