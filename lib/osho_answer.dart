import 'dart:convert';

import 'osho_request.dart';

class OshoAnswer {
  OshoRequest request;

  OshoAnswer(this.request);

  Future<void> send(int status, dynamic data) async {
    if (request.closed) return;

    request.src.response.statusCode = status;
    if (data is Map || data is List) data = jsonEncode(data);
    if (data != null) request.src.response.write(data);

    await request.src.response.close();
    request.closed = true;
  }
}
