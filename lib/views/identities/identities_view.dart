import 'package:components/dashboard_header/dashboard_header.dart';
import 'package:components/identity_card/identity_card.dart';
import 'package:components/main_navigation/main_navigation.dart';
import 'package:components/navigation_menu/navigation_menu.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/identities/identities_viewmodel.dart';
import 'package:stacked/stacked.dart';

class IdentititesView extends StatelessWidget {
  const IdentititesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => IdentitiesViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(child: MainNavigation()),
            Expanded(
              child: Container(
                color: ThemeStyles.theme.background300,
                child: Column(
                  children: [
                    DashboardHeader(
                      icon: "certificate.svg",
                      name: "Certificates",
                      type: ActiveNavigationPage.identities,
                      onNewPassword: viewModel.onGenerateCertificate,
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: viewModel.identities.length,
                        itemBuilder: (context, index) => IdentityCard(
                          identity: viewModel.identities.elementAt(index),
                        ),
                      ),
                    ),
                    NavigationMenu(
                      currentPage: ActiveNavigationPage.identities,
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
