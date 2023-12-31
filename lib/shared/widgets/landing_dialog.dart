import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/gen/assets.gen.dart';
import 'package:su_thesis_book/theme/theme.dart';

extension LandingDialogExt on BuildContext {
  /// {@macro show}
  Future<T?> showLandingDialog<T extends Object?>() =>
      LandingDialog.show<T>(this);
}

/// Full screen landing dialog.
class LandingDialog extends StatelessWidget {
  const LandingDialog({super.key});

  /// {@template show}
  /// Method to show landing dialog.
  /// {@endtemplate}
  static Future<T?> show<T extends Object?>(BuildContext context) =>
      showGeneralDialog<T>(
        context: context,
        transitionDuration: const Duration(milliseconds: 1000),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LandingDialog(),
      );

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();

    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  // App Logo
                  SvgPicture.asset(
                    Assets.images.logo01Transparent,
                    placeholderBuilder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                    semanticsLabel: 'App Logo',
                    width: context.mediaQuery.size.aspectRatio * 725,
                  ),
                  Text(
                    'SU Research & Thesis Book',
                    style: context.theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.inverseSurface
                          .withOpacity(.75),
                    ),
                  ),
                ],
              ),
              // Get Started button
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppThemes.height * 10,
                ),
                child: SizedBox(
                  height: kToolbarHeight,
                  width: context.mediaQuery.size.width * .75,
                  child: ElevatedButton(
                    onPressed: cubit.onGetStarted,
                    style: ButtonStyle(
                      textStyle: MaterialStatePropertyAll(
                        context.theme.textTheme.headlineSmall,
                      ),
                    ),
                    child: const Text('Get Started'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
