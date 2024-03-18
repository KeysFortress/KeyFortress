import 'package:components/custom_button/custom_button.dart';
import 'package:components/identity_card/identity_card.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
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
            SafeArea(
              child: NavMenuInner(
                location: "Identities",
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
                  callback: viewModel.onGenerateCertificate,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: ThemeStyles.theme.background300,
                child: ListView.builder(
                  itemCount: viewModel.identities.length,
                  itemBuilder: (context, index) => IdentityCard(
                    identity: viewModel.identities.elementAt(index),
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
