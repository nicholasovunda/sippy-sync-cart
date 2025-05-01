import 'package:auto_route/auto_route.dart';
import 'package:sippy_cart_sharing/routes/auto_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter() : super();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: CartSummaryRoute.page),
    AutoRoute(page: ProductRoute.page),
  ];
}
