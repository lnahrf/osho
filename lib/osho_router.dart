import 'dart:io';

import 'http_methods.dart';
import 'osho_answer.dart';
import 'osho_body_parser.dart';
import 'osho_request.dart';
import 'osho_route.dart';

class OshoRouter extends OshoRouterHandler with OshoBodyParser {
  final List<Function(OshoRequest request)> _tunnels = [];

  final OshoRoute _defaultRoute = OshoRoute(
      "/_default",
      (request) => OshoAnswer(request).send(HttpStatus.notFound, null),
      HttpMethods.DEFAULT);

  Future<void> stream(HttpServer server) async {
    await for (HttpRequest request in server) {
      await _runRoute(OshoRequest(request), request.method);
    }
  }

  void tunnel(Function(OshoRequest request) tunnel) {
    Future<void> smartTunnel(OshoRequest request) async {
      if (request.closed) return;
      await tunnel(request);
    }

    _tunnels.add(smartTunnel);
  }

  OshoAnswer answer(OshoRequest request) {
    return OshoAnswer(request);
  }

  Future<void> _runRoute(OshoRequest request, String method) async {
    final route = super.routes.firstWhere(
        (route) =>
            route.path == request.src.uri.toString() && route.method == method,
        orElse: () => _defaultRoute);
    await _runTunnels(request);
    await route.handler(request);
  }

  Future<void> _runTunnels(OshoRequest request) async {
    for (Function(OshoRequest request) tunnel in _tunnels) {
      await tunnel(request);
    }
  }
}

class OshoRouterHandler {
  List<OshoRoute> routes = [];

  void get(String path, Function(OshoRequest request) handler) {
    final route = OshoRoute(path, handler, HttpMethods.GET);
    routes.add(route);
  }

  void post(String path, Function(OshoRequest request) handler) {
    final route = OshoRoute(path, handler, HttpMethods.POST);
    routes.add(route);
  }
}
