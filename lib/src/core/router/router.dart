


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skin_care/src/core/router/router.gr.dart';


class AppRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint("Going to : ${route.settings.name}");
  }
}

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthRoute.page, path: "/auth", initial: true),
    AutoRoute(page: SkinCareRoute.page, path: "/skincare"),
    AutoRoute(page: NoInternetRoute.page,path: "/noInternet")
  ];
}
