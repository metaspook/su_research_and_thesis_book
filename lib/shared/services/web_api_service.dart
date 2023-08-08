import 'dart:developer';

import 'package:http/http.dart';

class ApiService {
  const ApiService();

  // Common headers
  Map<String, String> get _headers => const {
        'Accept': '*/*',
        'User-Agent': 'Thunder Client (https://www.thunderclient.com)'
      };
  bool _success(int code) => code >= 200 && code < 300;
  String _errorMsg(String objName) => "[FAIL!] Couldn't fetch $objName";

  Future<StreamedResponse?> fetchComments() async {
    final url = Uri.parse('https://dummyjson.com/comments?limit=10');
    final request = Request('GET', url);
    request.headers.addAll(_headers);
    const objName = 'Comments';

    try {
      final response = await request.send();
      return _success(response.statusCode)
          ? response
          : throw Exception(_errorMsg(objName));
    } catch (e, s) {
      log(_errorMsg(objName), error: e, stackTrace: s);
    }
    return null;
  }
}
