import 'package:components/custom_button/custom_button.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:components/secret_card/secret_card.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/passwords/passwords_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PasswordsView extends StatelessWidget {
  const PasswordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PasswordsViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(
              child: NavMenuInner(
                location: "Passwords",
                callback: () => viewModel.router.backToPrevious(context),
                button: CustomButton(
                  widget: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: ThemeStyles.theme.accent100,
                        size: 37.33,
                      )
                    ],
                  ),
                  callback: viewModel.onGeneratePassword,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: ThemeStyles.theme.background300,
                child: ListView.builder(
                  itemCount: viewModel.secrets.length,
                  itemBuilder: (context, index) => SecretCard(
                    secret: viewModel.secrets.elementAt(index),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
