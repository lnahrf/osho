import 'dart:io';

import 'package:osho/osho.dart';
import 'package:osho/osho_header.dart';

void main() async {
  final osho = Osho();

  osho.tunnel((request) async {
    request.setHeaders(
        [OshoHeader(HttpHeaders.contentTypeHeader, "application/json")]);
  });

  osho.get("/", (request) async {
    await osho.answer(request).send(HttpStatus.ok, [
      {"title": "hi"}
    ]);
  });

  await osho.run(3000);
  print("Osho server is live");
}
