import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/gen/assets.gen.dart';
import 'package:su_thesis_book/theme/theme.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();

    return Scaffold(
      backgroundColor: context.theme.colorScheme.inverseSurface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // App Logo
          SvgPicture.asset(
            Assets.images.logo01Transparent,
            placeholderBuilder: (context) =>
                const Center(child: CircularProgressIndicator()),
            semanticsLabel: 'App Logo',
            width: 425,
          ),
          // Get Started button
          SizedBox(
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
        ],
      ),
    );
  }
}
