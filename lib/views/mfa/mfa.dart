import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_text_field/custom_text_field.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/mfa/mfa_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MfaView extends StatelessWidget {
  const MfaView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MfaViewModel(context),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(
              child: NavMenuInner(
                location: "Confirm MFA",
                callback: () => viewModel.router.backToPrevious(context),
              ),
            ),
            CustomTextField(
              floatingLabel: "MFA Code",
              onChange: viewModel.onMfaChanged,
            )
          ],
        ),
      ),
    );
  }
}
