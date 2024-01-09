import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/custom_icon_button/custom_icon_button.dart';
import 'package:presentation/components/custom_text_field/custom_text_field.dart';
import 'package:presentation/components/password_entry_box/password_entry_box.viewmodel.dart';
import 'package:presentation/components/password_strenght/password_strenght.dart';
import 'package:stacked/stacked.dart';

class PasswordEntryBox extends StatelessWidget {
  final String password;
  final Function onSave;
  const PasswordEntryBox({
    super.key,
    required this.password,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PasswordEntryBoxViewModel(context, password),
      builder: (context, viewModel, child) => Container(
        color: ThemeStyles.theme.background200,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                width: double.infinity,
                height: 5,
                decoration: BoxDecoration(
                  color: ThemeStyles.theme.accent200,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              CustomTextField(
                floatingLabel: "Name",
                onChange: viewModel.onNameChanged,
                height: 50,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                floatingLabel: "Email",
                onChange: viewModel.onEmailChanged,
                height: 50,
              ),
              const SizedBox(height: 8),
              Text(
                password,
                style: ThemeStyles.regularInnerHeading,
              ),
              const SizedBox(height: 8),
              PasswordStrenght(initial: password),
              const SizedBox(height: 8),
              CustomIconButton(
                label: "Save",
                callback: () {
                  viewModel.onSave();
                  onSave.call();
                },
              ),
              const SizedBox(height: 8),
              Text(
                "Passwords are automatically copied after saving",
                style: ThemeStyles.regularParagraph,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
