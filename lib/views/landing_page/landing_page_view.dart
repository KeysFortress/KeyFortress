import 'package:components/dashboard_header/dashboard_header.dart';
import 'package:components/identity_card/identity_card.dart';
import 'package:components/main_navigation/main_navigation.dart';
import 'package:components/navigation_menu/navigatioon_menu.dart';
import 'package:components/secret_card/secret_card.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/landing_page/landing_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LandingPageView extends StatelessWidget {
  const LandingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LandingPageViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.background300,
        child: Column(
          children: [
            MainNavigation(),
            DashboardHeader(
              type: viewModel.activePage,
              onNewPassword: viewModel.onGenerateNewPassword,
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount:
                    viewModel.activePage == ActiveNavigationPage.passwords
                        ? viewModel.secrets.length
                        : viewModel.identities.length,
                itemBuilder: (context, index) =>
                    viewModel.activePage == ActiveNavigationPage.passwords
                        ? SecretCard(
                            secret: viewModel.secrets.elementAt(index),
                          )
                        : IdentityCard(
                            identity: viewModel.identities.elementAt(index),
                          ),
              ),
            ),
            NavigationMenu(
              onPageChanged: viewModel.onPageChanged,
            ),
          ],
        ),
      ),
    );
  }
}
