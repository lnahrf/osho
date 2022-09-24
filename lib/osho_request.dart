import 'dart:io';

import 'package:osho/osho_header.dart';

class OshoRequest {
  bool closed = false;
  dynamic body;
  HttpRequest src;

  OshoRequest(this.src);

  void addHeader(OshoHeader header) {
    if (closed) return;
    src.response.headers.removeAll(header.type);
    src.response.headers.add(header.type, header.value);
  }

  void setHeaders(List<OshoHeader> headers) {
    if (closed) return;
    for (final header in headers) {
      src.response.headers.removeAll(header.type);
      addHeader(header);
    }
  }
}
