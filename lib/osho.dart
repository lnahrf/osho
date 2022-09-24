import 'dart:io';
import 'osho_router.dart';

class Osho extends OshoRouter {
  late int port;
  late HttpServer instance;
  late InternetAddress address;

  Future<HttpServer> run(int port, {v6 = false}) async {
    if (v6) {
      address = InternetAddress.loopbackIPv6;
    } else {
      address = InternetAddress.loopbackIPv4;
    }

    this.port = port;
    instance = await HttpServer.bind(address, port);
    super.stream(instance);
    return instance;
  }
}

/**
 * TODO:
 * Group routers under a RouteGroup
 * Client:
 *  Renderer
 *  API Bridge
 *  The page gets rendered based on data passed to the render method. when the data changes, call a method that rerenders the page.
 */