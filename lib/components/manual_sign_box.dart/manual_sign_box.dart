import 'package:domain/models/stored_identity.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/custom_icon_button/custom_icon_button.dart';
import 'package:presentation/components/custom_text_field/custom_text_field.dart';
import 'package:presentation/components/manual_sign_box.dart/manual_sign_box.viewmodel.dart';
import 'package:presentation/components/password_strenght/password_strenght.dart';
import 'package:stacked/stacked.dart';

class ManualSignBox extends StatelessWidget {
  final Function onSave;
  final StoredIdentity identity;
  const ManualSignBox({
    super.key,
    required this.identity,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ManualSignBoxViewModel(context, identity),
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
                floatingLabel: "Message",
                onChange: viewModel.onMessageChanged,
                height: 50,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                floatingLabel: "Data",
                onChange: viewModel.onDataChanged,
                height: 50,
              ),
              const SizedBox(height: 8),
              CustomIconButton(
                label: "Sign",
                callback: () {
                  viewModel.onSave();
                  onSave.call();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
