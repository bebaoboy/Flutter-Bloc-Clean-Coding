// Importing necessary packages and files
import 'package:bloc_clean_coding/repository/auth_api/auth_api_repository.dart';
import 'package:bloc_clean_coding/repository/auth_api/auth_mock_api_repository.dart';
import 'package:bloc_clean_coding/repository/movies_api/movies_api_repository.dart';
import 'package:bloc_clean_coding/repository/movies_api/movies_http_api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Localization support
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart'; // Package for dependency injection

import 'configs/routes/routes.dart'; // Custom routes
import 'configs/themes/dark_theme.dart'; // Dark theme configuration
import 'configs/themes/light_theme.dart'; // Light theme configuration

// GetIt is a package used for service locator or to manage dependency injection
GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensuring that Flutter bindings are initialized
  servicesLocator(); // Initializing service locator for dependency injection
  runApp(const MyApp()); // Running the application
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for MyApp widget

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp.router(
            // Material app configuration
            title: 'Flutter Demo',
            themeMode: ThemeMode.system, // Setting theme mode to dark
            theme: lightTheme, // Setting light theme
            darkTheme: darkTheme, // Setting dark theme
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English locale
              Locale('es'), // Spanish locale
            ],
            // initialRoute: RoutesName.splash, // Initial route
            // onGenerateRoute: Routes.generateRoute, // Generating routes
            routerConfig: Routes.router,
          );
        });
  }
}

// Function for initializing service locator
void servicesLocator() {
  // Registering AuthHttpApiRepository as a lazy singleton for AuthApiRepository
  // getIt.registerLazySingleton<AuthApiRepository>(() => AuthHttpApiRepository());
  getIt.registerLazySingleton<AuthApiRepository>(() => AuthMockApiRepository());
  // Registering MoviesHttpApiRepository as a lazy singleton for MoviesApiRepository
  getIt.registerLazySingleton<MoviesApiRepository>(
      () => MoviesHttpApiRepository());
}
