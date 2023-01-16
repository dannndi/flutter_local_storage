import 'package:flutter/material.dart';
import 'package:local_storage/feature/home/presentation/home_screen.dart';
import '/core/route/app_route_name.dart';

class AppRoute {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case "/template":
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const SizedBox(),
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
    }

    return null;
  }
}
