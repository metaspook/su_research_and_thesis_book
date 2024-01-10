import 'package:flutter/material.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';

typedef Json = Map<String, Object?>;
typedef Papers = ({List<Research>? researches, List<Thesis>? theses});

// extension PublishersExt on Papers {
//   List<Publisher>? get publishers => (theses == null && researches == null)
//       ? null
//       : <Publisher>[
//           // These
//           if (theses != null)
//             for (final e in theses!)
//               if (e.publisher != null) e.publisher!,
//           // Research
//           if (researches != null)
//             for (final e in researches!)
//               if (e.publisher != null) e.publisher!,
//         ];
// }

typedef IconButtonRecord = ({
  IconData icon,
  String label,
  Color color,
  void Function()? onPressed
});
