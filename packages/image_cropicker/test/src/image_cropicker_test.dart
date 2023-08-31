// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_cropicker/image_cropicker.dart';

void main() {
  group('ImageCropicker', () {
    testWidgets('can be instantiated.', (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            expect(ImageCropicker(context), isNotNull);
            return Placeholder();
          },
        ),
      );
    });
    // test('can be instantiated', () {
    //   expect(ImageCropicker(), isNotNull);
    // });
  });
}
