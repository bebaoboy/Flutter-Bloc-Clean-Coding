import 'package:bloc_clean_coding/utils/extensions/flush_bar_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../configs/routes/routes_name.dart';
import '../../../utils/enums.dart';

/// A widget representing the submit button for the login form.
class SubmitButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final formKey;
  const SubmitButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(
      listenWhen: (current, previous) => current.postApiStatus != previous.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.error) {
          context.flushBarErrorMessage(message: state.message.toString());
        }

        if (state.postApiStatus == PostApiStatus.success) {
          context.go(RoutesName.home);
        }
      },
      child: BlocBuilder<LoginBloc, LoginStates>(
          buildWhen: (current, previous) => current.postApiStatus != previous.postApiStatus,
          builder: (context, state) {
            return ElevatedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    context.read<LoginBloc>().add(LoginApi());
                  }
                },
                child: state.postApiStatus == PostApiStatus.loading ? const CircularProgressIndicator() : const Text('Login'));
          }),
    );
  }
}
