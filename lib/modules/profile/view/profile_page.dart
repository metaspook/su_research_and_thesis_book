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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        children: [
          // Assets.images.placeholderUser01.image(fit: BoxFit.cover),
          const HaloAvatar(
            imagePath:
                'https://cdn.icon-icons.com/icons2/2468/PNG/512/user_kids_avatar_user_profile_icon_149314.png',
            size: 4,
          ),
          const SizedBox(height: 30),
          Card(
            child: Column(
              children: [
                // DataTable(
                //   horizontalMargin: 0,
                //   columnSpacing: 0,
                //   columns: const [
                //     DataColumn(label: SizedBox.shrink()),
                //     DataColumn(label: SizedBox.shrink()),
                //   ],
                //   rows: [
                //     DataRow(
                //       cells: [
                //         DataCell(_textFormField('Name:')),
                //         DataCell(_textFormField('Raifur Rahman')),
                //       ],
                //     ),
                //     DataRow(
                //       cells: [
                //         DataCell(_textFormField('Role:')),
                //         DataCell(_textFormField('Raifur Rahman')),
                //       ],
                //     ),
                //   ],
                // ),
                _textFormField('Name   : Raifur Rahman'),
                _textFormField('Role   : Student'),
                _textFormField('Phone  : +01344886532'),
                _textFormField('E-mail : example@mail.com'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFormField(String initialValue) => TextFormField(
        initialValue: initialValue,
        // enabled: false,
        readOnly: true,
        decoration: const InputDecoration(
          filled: true,
        ),
      );
}
