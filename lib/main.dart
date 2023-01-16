import 'package:flutter/material.dart';
import 'package:local_storage/main_module.dart';

import 'core/route/app_route.dart';
import 'core/route/app_route_name.dart';
import 'core/theme/app_theme.dart';

/// Follow me on
/// Youtube : Dannndi
/// IG : dannndi.ig
/// Tiktok : dannndi.tt
///
/// Like & Subscribe

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MainModule.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Local Storage",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: AppRouteName.home,
      onGenerateRoute: AppRoute.generate,
    );
  }
}
