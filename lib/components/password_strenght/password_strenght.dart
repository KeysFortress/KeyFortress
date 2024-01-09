import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/password_strenght/password_strenght_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PasswordStrenght extends StatelessWidget {
  final String? initial;
  const PasswordStrenght({super.key, this.initial});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PasswordStrenghtViewModel(context, initial),
      builder: (context, viewModel, child) => Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: viewModel.strenght >= 1
                    ? ThemeStyles.theme.primary100
                    : ThemeStyles.theme.background100,
                borderRadius: BorderRadius.circular(2),
              ),
              padding: EdgeInsets.all(2),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: viewModel.strenght >= 2
                    ? ThemeStyles.theme.primary100
                    : ThemeStyles.theme.accent200,
                borderRadius: BorderRadius.circular(2),
              ),
              padding: EdgeInsets.all(2),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: viewModel.strenght >= 3
                    ? ThemeStyles.theme.primary100
                    : ThemeStyles.theme.accent200,
                borderRadius: BorderRadius.circular(2),
              ),
              padding: EdgeInsets.all(2),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: viewModel.strenght >= 4
                    ? ThemeStyles.theme.primary100
                    : ThemeStyles.theme.accent200,
                borderRadius: BorderRadius.circular(2),
              ),
              padding: EdgeInsets.all(2),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
        ],
      ),
    );
  }
}
