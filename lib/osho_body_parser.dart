import 'dart:convert';

import 'http_methods.dart';
import 'osho_request.dart';

class OshoBodyParser {
  Future<void> parse(OshoRequest request) async {
    final bool shouldParse = request.src.method != HttpMethods.GET &&
        request.src.method != HttpMethods.DELETE &&
        request.src.method != HttpMethods.TRACE &&
        request.src.method != HttpMethods.OPTIONS &&
        request.src.method != HttpMethods.HEAD;
    if (!shouldParse) return;
    String body = await utf8.decoder.bind(request.src).join();
    request.body = jsonDecode(body);
  }
}
