import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../configs/routes/routes_name.dart'; // Importing the route names
import '../../../services/storage/local_storage.dart'; // Importing the LocalStorage class for managing local storage
import 'package:bloc_clean_coding/utils/language.dart'; // Importing app localizations for translated text

/// A widget representing the logout button.
class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LocalStorage localStorage = LocalStorage();
        localStorage.clearValue('token').then((value) {
          localStorage.clearValue('isLogin');
          context.go(RoutesName.login);
          // Navigating to the login screen after clearing token and isLogin value
        });
      },
      child: Center(
        child: Text(
          Lang.g(context).logout, // Localized text for logout button
        ),
      ),
    );
  }
}
