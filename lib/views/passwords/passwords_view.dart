import 'package:components/dashboard_header/dashboard_header.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:components/navigation_menu/navigation_menu.dart';
import 'package:components/secret_card/secret_card.dart';
import 'package:domain/models/enums.dart';
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
              ),
            ),
            Expanded(
              child: Container(
                color: ThemeStyles.theme.background300,
                child: Column(
                  children: [
                    DashboardHeader(
                      icon: "secrets.svg",
                      name: "Passwords",
                      type: ActiveNavigationPage.passwords,
                      onNewPassword: viewModel.onGeneratePassword,
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: viewModel.secrets.length,
                        itemBuilder: (context, index) => SecretCard(
                          secret: viewModel.secrets.elementAt(index),
                        ),
                      ),
                    ),
                    NavigationMenu(
                      currentPage: ActiveNavigationPage.passwords,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
