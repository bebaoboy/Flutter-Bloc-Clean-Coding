import 'dart:async'; // Importing dart:async for asynchronous operations

import 'package:flutter/material.dart'; // Importing Flutter material library
import 'package:go_router/go_router.dart';

import '../../../configs/routes/routes_name.dart'; // Importing routes names for navigation
import '../session_manager/session_controller.dart'; // Importing session controller for managing user session

/// A class containing services related to the splash screen.
class SplashServices {
  /// Checks authentication status and navigates accordingly.
  ///
  /// Takes a [BuildContext] as input and navigates to the home screen if the user is authenticated,
  /// otherwise navigates to the login screen after a delay of 2 seconds.
  void checkAuthentication(BuildContext context) async {
    SessionController().getUserFromPreference().then((value) async {
      if (SessionController.isLogin ?? false) {
        Timer(
          const Duration(seconds: 2),
          () => context.go(RoutesName.home),
        );
      } else {
        Timer(
          const Duration(seconds: 2),
          () => context.go(RoutesName.login),
        );
      }
    }).onError((error, stackTrace) {
      Timer(
        const Duration(seconds: 2),
          () => context.go(RoutesName.login),
      );
    });
  }
}
