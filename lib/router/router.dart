import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/modules/bookmarks/bookmarks.dart';
import 'package:su_thesis_book/modules/comments/comments.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/modules/password_reset/password_reset.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/modules/publisher/publisher.dart';
import 'package:su_thesis_book/modules/publishers/publishers.dart';
import 'package:su_thesis_book/modules/thesis/thesis.dart';
import 'package:su_thesis_book/modules/thesis_entry/thesis_entry.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

// Exposes routing interface for views.
export 'package:go_router/go_router.dart' show GoRoute, GoRouterHelper;

part 'app_router.dart';
