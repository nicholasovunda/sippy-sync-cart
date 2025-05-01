// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:sippy_cart_sharing/feature/cart/presentation/cart_summary_screen.dart'
    as _i1;
import 'package:sippy_cart_sharing/feature/product/presentation/product_list.dart'
    as _i3;
import 'package:sippy_cart_sharing/main.dart' as _i2;

/// generated route for
/// [_i1.CartSummaryScreen]
class CartSummaryRoute extends _i4.PageRouteInfo<void> {
  const CartSummaryRoute({List<_i4.PageRouteInfo>? children})
    : super(CartSummaryRoute.name, initialChildren: children);

  static const String name = 'CartSummaryRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.CartSummaryScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.ProductScreen]
class ProductRoute extends _i4.PageRouteInfo<void> {
  const ProductRoute({List<_i4.PageRouteInfo>? children})
    : super(ProductRoute.name, initialChildren: children);

  static const String name = 'ProductRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.ProductScreen();
    },
  );
}
