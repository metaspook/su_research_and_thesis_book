import 'dart:convert';

import 'package:su_thesis_book/shared/shared.dart';
import 'package:su_thesis_book/utils/utils.dart';

class CommentsRepo {
  const CommentsRepo();
  WebApiService get _webApiService => const WebApiService();

  Future<List<Comment>> fetchComments() async {
    final response = await _webApiService.requestComments();

    if (response != null) {
      final json =
          await response.stream.bytesToString().then(jsonDecode) as Json;
      final commentJsons = json['comments'] as List;
      return [for (final e in commentJsons) Comment.fromJson(e as Json)];
    }
    return [];
  }
}
