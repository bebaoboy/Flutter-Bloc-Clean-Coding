import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/login_bloc/login_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Importing app localizations for translated text

/// A widget representing the email input field.
class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value, // Setting initial value of email input field
          focusNode: focusNode, // Setting focus node
          decoration: InputDecoration(
            icon: const Icon(Icons.email), // Icon for email input field
            labelText: AppLocalizations.of(context)!.email, // Label text for email input field
            helperText: AppLocalizations.of(context)!
                .aCompleteValidEmailExamplejoegmailcom, // Helper text for email input field
            errorText: state.email.displayError != null
                ? AppLocalizations.of(context)!
                    .pleaseEnsureTheEmailEnteredIsValid // Error text for invalid email
                : null,
          ),
          keyboardType: TextInputType.emailAddress, // Setting keyboard type to email address
          onChanged: (value) {
            // Dispatching EmailChanged event when email input changes
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
