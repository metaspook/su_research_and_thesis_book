import 'package:flutter/material.dart';
import 'package:su_thesis_book/theme/theme.dart';

// Config
// <implement here, if any>

/// Callable Widget Extensions.
extension CallableWidgetExt on BuildContext {
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  // bool get keyboardVisible => MediaQuery.of(this).viewInsets.bottom != 0;

  Widget emptyListText([String? text]) => Center(
        child: Text(text ?? 'Empty!', style: theme.textTheme.displayMedium),
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
  Widget sliverAppBar(
    String title, {
    List<Widget>? actions,
    bool centerTitle = true,
  }) =>
      SliverAppBar(
        pinned: true,
        centerTitle: centerTitle,
        leading: backButton(),
        title: Text(title),
        actions: actions,
      );
}

/// PreferredSize Extensions.
extension PreferredSizeExt on Widget {
  /// Converts to a preferredSizeWidget. If size null, value fallback to Size.fromHeight(kToolbarHeight).
  PreferredSize toPreferredSize(Size? size) => PreferredSize(
        preferredSize: size ?? const Size.fromHeight(kToolbarHeight),
        child: this,
      );
}

/// `requestFocus` Extensions.
extension RequestFocus on FocusNode {
  void onSubmitted(String value) {
    if (value.isNotEmpty) requestFocus();
  }
}
