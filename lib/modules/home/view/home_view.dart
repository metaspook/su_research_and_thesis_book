import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final iconButtonRecords =
        <({IconData icon, String label, void Function()? onPressed})>[
      (
        label: 'All Thesis',
        icon: Icons.file_copy_rounded,
        onPressed: () {},
      ),
      (
        label: 'Category',
        icon: Icons.category_rounded,
        onPressed: () {},
      ),
      (
        label: 'Publishers',
        icon: Icons.group_rounded,
        onPressed: () {},
      ),
      (
        label: 'Upload Thesis',
        icon: Icons.upload_file_rounded,
        onPressed: () {},
      ),
      (
        label: 'Notifications',
        icon: Icons.notifications_rounded,
        onPressed: () {},
      ),
      (
        label: 'Profile',
        icon: Icons.person_rounded,
        onPressed: () {},
      ),
    ];

    return ListView(
      padding: AppThemes.verticalPadding * 2,
      children: [
        const ThesisCarousel(),
        GridView.count(
          padding: AppThemes.verticalPadding * 3,
          shrinkWrap: true,
          crossAxisCount: 3,
          childAspectRatio: 1.625,
          children: [
            for (var i = 0; i < iconButtonRecords.length; i++)
              IconButtonLabeled(
                iconButtonRecords[i],
                color: AppThemes.selectedColorsRandomized[i],
                size: context.mediaQuery.size.shortestSide * .09,
              ),
          ],
        ),
        const ProfileCarousel(),
      ],
    );
  }
}
