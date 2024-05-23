import 'package:bloc_clean_coding/configs/routes/routes_name.dart';

import '../../view/views.dart';
import 'package:go_router/go_router.dart';

class Routes {
// GoRouter configuration
  static final router = GoRouter(
    initialLocation: RoutesName.splash,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MoviesScreen(),
      ),
      GoRoute(
        path: RoutesName.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutesName.splash,
        builder: (context, state) => const SplashView(),
      ),
    ],
  );
  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case RoutesName.splash:
  //       return MaterialPageRoute(
  //           builder: (BuildContext context) => const SplashView());

  //     case RoutesName.home:
  //       return MaterialPageRoute(
  //           builder: (BuildContext context) => const MoviesScreen());

  //     case RoutesName.login:
  //       return MaterialPageRoute(
  //           builder: (BuildContext context) => const LoginScreen());

  //     default:
  //       return MaterialPageRoute(builder: (_) {
  //         return const Scaffold(
  //           body: Center(
  //             child: Text('No route defined'),
  //           ),
  //         );
  //       });
  //   }
  // }
}
