import 'package:flutter/material.dart';
import 'package:su_thesis_book/theme/app_themes.dart';

class ThesisCategoryBar extends StatelessWidget {
  const ThesisCategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < 10; i++) ...[
            ElevatedButton(onPressed: () {}, child: Text('Category $i')),
            const SizedBox(width: AppThemes.width),
          ],
          // const SizedBox(width: AppThemes.width),
        ],
      ),
    );
    // return Row(
    //   children: [
    //     ElevatedButton(onPressed: () {}, child: const Text('All')),
    //     const SizedBox(width: AppThemes.width),
    //     Expanded(
    //       child: SingleChildScrollView(
    //         physics: const BouncingScrollPhysics(),
    //         scrollDirection: Axis.horizontal,
    //         child: Row(
    //           children: [
    //             for (var i = 0; i < 10; i++) ...[
    //               ElevatedButton(onPressed: () {}, child: Text('Category $i')),
    //               const SizedBox(width: AppThemes.width),
    //             ],
    //             // const SizedBox(width: AppThemes.width),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
