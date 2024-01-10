import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:su_research_and_thesis_book/gen/assets.gen.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

// Config
SvgPicture? _authBanner;

/// Callable Widget Extensions.
extension CallableWidgetExt on BuildContext {
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  FocusScopeNode get focusScope => FocusScope.of(this);
  // bool get keyboardVisible => MediaQuery.of(this).viewInsets.bottom != 0;

  SvgPicture authBanner() => _authBanner ??= SvgPicture.asset(
        Assets.images.signinBanner01,
        placeholderBuilder: (context) =>
            const Center(child: CircularProgressIndicator()),
        semanticsLabel: 'Auth Logo',
        height: mediaQuery.size.height * .3,
      );
  Widget emptyListText({String? data, bool hasToolbarHeight = true}) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data ?? 'Empty!', style: theme.textTheme.displayMedium),
          SizedBox(height: hasToolbarHeight ? kToolbarHeight : null),
        ],
      );
  Widget? backButton<T extends Object?>([T? result]) => Navigator.canPop(this)
      ? IconButton(
          onPressed: () {
            final currentFocus = FocusScope.of(this);
            // currentFocus.hasPrimaryFocus.doPrint();
            // currentFocus.hasFocus.doPrint();
            (currentFocus.hasPrimaryFocus == currentFocus.hasFocus)
                ? Navigator.pop<T>(this, result)
                : currentFocus.unfocus();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        )
      : null;
  SliverAppBar sliverAppBar(
    String title, {
    bool centerTitle = true,
    PreferredSizeWidget? bottom,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    double? expandedHeight,
    Widget? flexibleSpace,
  }) {
    final backBtn = backButton();
    return SliverAppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      pinned: true,
      floating: true,
      snap: true,
      leading: backBtn == null && leading == null
          ? null
          : Row(
              children: [
                if (backBtn != null && automaticallyImplyLeading) backBtn,
                if (leading != null) leading,
              ],
            ),
      expandedHeight: expandedHeight,
      flexibleSpace: flexibleSpace,
      // flexibleSpace: FlexibleSpaceBar(
      //   centerTitle: true,
      //   title: Text(title),
      //   background: Image.asset(
      //     Assets.images.mathematics01.path,
      //     fit: BoxFit.cover,
      //   ),
      // ),
      centerTitle: centerTitle,
      title: Text(title),
      bottom: bottom,
      actions: actions,
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showAppSnackBar(
    String? statusMsg,
  ) {
    final snackBar = SnackBar(
      backgroundColor: theme.snackBarTheme.backgroundColor?.withOpacity(.25),
      behavior: SnackBarBehavior.floating,
      content: Text(statusMsg.toStringParseNull()),
    );
    return scaffoldMessenger.showSnackBar(snackBar);
  }
}

extension ToBoldExt on TextStyle {
  TextStyle toBold([FontWeight fontWeight = FontWeight.bold]) =>
      copyWith(fontWeight: fontWeight);
}

/// PreferredSize Extensions.
extension PreferredSizeExt on Widget {
  /// Converts to a preferredSizeWidget. If size null, value fallback to Size.fromHeight(kToolbarHeight).
  PreferredSize toPreferredSize([Size? size]) => PreferredSize(
        preferredSize: size ?? const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(child: this),
      );

  Widget withToolbarHeight() => SizedBox(height: kToolbarHeight, child: this);
}

/// `requestFocus` Extensions.
extension RequestFocus on FocusNode {
  void onSubmitted(String value) {
    if (value.isNotEmpty) requestFocus();
  }
}
