import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/nav_menu_inner/nav_menu_inner.dart';
import 'package:presentation/views/identity_history/identity_history_viewmodel.dart';
import 'package:stacked/stacked.dart';

class IdentityHistoryView extends StatelessWidget {
  const IdentityHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => IdentityHistoryViewModel(context),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.background300,
        child: SafeArea(
          child: Column(
            children: [
              NavMenuInner(
                location: viewModel.identity.name,
                callback: viewModel.router.backToPrevious,
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => Placeholder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
