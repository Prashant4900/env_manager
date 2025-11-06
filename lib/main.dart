import 'dart:async';

import 'package:env_manager/constants/app_colors.dart';
import 'package:env_manager/pages/home_page.dart';
import 'package:env_manager/providers/environment_provider.dart';
import 'package:env_manager/utils/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      // Initialize Flutter binding
      WidgetsFlutterBinding.ensureInitialized();

      // Initialize window manager
      await windowManager.ensureInitialized();

      const windowOptions = WindowOptions(
        size: Size(1200, 800),
        minimumSize: Size(1200, 800),
        maximumSize: Size(1200, 800),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
      );

      await windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });

      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => EnvironmentProvider()),
          ],
          child: const MyApp(),
        ),
      );
    },
    (error, stackTrace) {
      AppLogger.error(error.toString(), stackTrace: stackTrace);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1200, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: const Color(0xFFF9FAFB),
            navigationRailTheme: NavigationRailThemeData(
              backgroundColor: Colors.transparent,
              groupAlignment: 0,
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
                size: 28,
              ),
              unselectedIconTheme: IconThemeData(
                color: Colors.white.withValues(alpha: 0.6),
              ),
              selectedLabelTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelTextStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
              ),
              indicatorColor: Colors.white.withValues(alpha: 0.12),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(
                  AppColors.backgroundDark,
                ),
                foregroundColor: const WidgetStatePropertyAll(
                  Colors.white,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                elevation: const WidgetStatePropertyAll(0),
              ),
            ),
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}
