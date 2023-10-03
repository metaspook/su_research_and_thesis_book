import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppThemes.verticalPadding),
      children: [
        const ThesisCarousel(),
        GridView.count(
          padding: AppThemes.viewPadding,
          shrinkWrap: true,
          crossAxisCount: 3,
          childAspectRatio: 1.625,
          children: [..._iconButtonRecords.map(IconButtonLabeled.new)],
        ),
        const ProfileCarousel(),
      ],
    );
  }
}

final _iconButtonRecords =
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
