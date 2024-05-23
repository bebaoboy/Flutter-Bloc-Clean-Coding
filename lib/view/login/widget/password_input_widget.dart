import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_clean_coding/utils/language.dart'; // Importing app localizations for translated text
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../bloc/login_bloc/login_bloc.dart';

/// A widget representing the password input field.
class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(builder: (context, state) {
      return TextFormField(
          focusNode: focusNode, // Setting focus node
          decoration: InputDecoration(
            icon: const Icon(Icons.lock), // Icon for password input field
            helperText: Lang.g(context)
                .passwordShouldbeatleast_characterswithatleastoneletterandnumber, // Helper text for password input field
            helperMaxLines: 2, // Maximum lines for helper text
            labelText:
                Lang.g(context).password, // Label text for password input field
            errorMaxLines: 2, // Maximum lines for error text
          ),
          onChanged: (value) {
            // Dispatching PasswordChanged event when password input changes
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
          obscureText:
              true, // Making the text input obscure (i.e., showing dots instead of actual characters)
          validator: FormBuilderValidators.compose([
            /// Makes this field required
            FormBuilderValidators.required(),

            /// Sets a maximum value of 70
            FormBuilderValidators.minLength(6,
                errorText: 'please enter password greater than 6 char'),

            /// Include your own custom `FormFieldValidator` function, if you want
            /// Ensures positive values only. We could also have used `FormBuilderValidators.min(0)` instead
          ]));
    });
  }
}
