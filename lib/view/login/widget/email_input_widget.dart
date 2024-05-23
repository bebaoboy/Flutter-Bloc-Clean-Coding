import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_clean_coding/utils/language.dart'; // Importing app localizations for translated text
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../bloc/login_bloc/login_bloc.dart';

/// A widget representing the email input field.
class EmailInput extends StatelessWidget {
  const EmailInput({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      builder: (context, state) {
        return TextFormField(
          focusNode: focusNode, // Setting focus node
          decoration: InputDecoration(
            icon: const Icon(Icons.email), // Icon for email input field
            labelText:
                Lang.g(context).email, // Label text for email input field
            helperText: Lang.g(context)
                .aCompleteValidEmailExamplejoegmailcom, // Helper text for email input field
          ),
          keyboardType: TextInputType
              .emailAddress, // Setting keyboard type to email address
          onChanged: (value) {
            // Dispatching EmailChanged event when email input changes
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },
          validator: FormBuilderValidators.compose([
            /// Makes this field required
            FormBuilderValidators.required(),

            /// Ensures the value entered is numeric - with a custom error message
            FormBuilderValidators.email(errorText: 'Email is not correct'),

            /// Sets a maximum value of 70
            // FormBuilderValidators.max(70),

            /// Include your own custom `FormFieldValidator` function, if you want
            /// Ensures positive values only. We could also have used `FormBuilderValidators.min(0)` instead
            // (val) {
            //   final number = int.tryParse(val);
            //   if (number == null) return null;
            //   if (number < 0) return 'We cannot have a negative age';
            //   return null;
            // },
          ]),

          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
