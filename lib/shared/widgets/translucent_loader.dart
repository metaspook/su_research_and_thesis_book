import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

class TranslucentLoader extends StatelessWidget {
  const TranslucentLoader({
    super.key,
    this.child,
    this.value,
    this.enabled = true,
    this.addToolbarHeight = true,
  });
  final Widget? child;
  final double? value;
  final bool enabled;
  final bool addToolbarHeight;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final circularProgressIndicator = CircularProgressIndicator(
      value: value,
      color: primaryColor.withOpacity(.5),
    );

    return AbsorbPointer(
      absorbing: enabled,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          if (child != null) child!,
          if (enabled)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: 'L',
                      style: TextStyle(
                        fontSize: circularProgressIndicator.strokeWidth * 12.75,
                        fontWeight: FontWeight.w400,
                        color: primaryColor,
                      ),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: circularProgressIndicator,
                        ),
                        const TextSpan(text: 'ADING'),
                      ],
                    ),
                  ),
                  if (addToolbarHeight) const SizedBox(height: kToolbarHeight),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// class TranslucentLoadingStack extends Stack {
//   TranslucentLoadingStack({
//     super.key,
//     required BuildContext context,
//     Widget? child,
//     bool disabled = false,
//   }) : super(

//           children: [
//             if (child != null) child,
//             if (!disabled)
//               BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: RichText(
//                     text: TextSpan(
//                         text: 'L',
//                         style: TextStyle(
//                             fontSize:
//                                 MediaQuery.of(context).size.shortestSide * .125,
//                             fontWeight: FontWeight.w400,
//                             color: Theme.of(context)
//                                 .primaryColorDark
//                                 .withOpacity(.75)),
//                         children: const [
//                           WidgetSpan(
//                             alignment: PlaceholderAlignment.middle,
//                             child: CircularProgressIndicator(),
//                           ),
//                           TextSpan(text: 'ADING')
//                         ]),
//                   ),
//                 ),
//               ),
//           ],
//         );
// }

// Container(
//                         padding: EdgeInsets.all(
//                             MediaQuery.of(context).size.shortestSide * .075),
//                         decoration: ShapeDecoration(
//                             color: Theme.of(context)
//                                 .primaryColorDark
//                                 .withOpacity(.25),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10))),

//                     ),
