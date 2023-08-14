import 'package:flutter/material.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // File('d:/lab/projects/su_thesis_book/assets/images/placeholder_user_01.jpg')
    //     .readAsBytes()
    //     .then(print);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: const [
          // Assets.images.placeholderUser01.image(fit: BoxFit.cover),
          HaloAvatar(
            imagePath:
                'https://cdn.icon-icons.com/icons2/2468/PNG/512/user_kids_avatar_user_profile_icon_149314.png',

            // size: 3,
          ),
          Placeholder(),
        ],
      ),
    );
  }
}
