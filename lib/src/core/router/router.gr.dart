// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:skin_care/src/comman/screens/no_internet.dart' as _i2;
import 'package:skin_care/src/features/auth/presentation/screens/auth_screen.dart'
    as _i1;
import 'package:skin_care/src/features/skincare/presentation/screens/skincare.dart'
    as _i3;

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i4.PageRouteInfo<void> {
  const AuthRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthScreen();
    },
  );
}

/// generated route for
/// [_i2.NoInternetScreen]
class NoInternetRoute extends _i4.PageRouteInfo<void> {
  const NoInternetRoute({List<_i4.PageRouteInfo>? children})
      : super(
          NoInternetRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoInternetRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.NoInternetScreen();
    },
  );
}

/// generated route for
/// [_i3.SkinCareScreen]
class SkinCareRoute extends _i4.PageRouteInfo<void> {
  const SkinCareRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SkinCareRoute.name,
          initialChildren: children,
        );

  static const String name = 'SkinCareRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SkinCareScreen();
    },
  );
}
