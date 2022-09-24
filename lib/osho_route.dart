import 'osho_request.dart';

class OshoRoute {
  String path;
  Function(OshoRequest request) handler;
  String method;

  OshoRoute(this.path, this.handler, this.method);
}
