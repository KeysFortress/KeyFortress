import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/components/secret_container/secret_container_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SecretContainer extends StatelessWidget {
  final IconData icon;
  final String display;
  final String value;

  const SecretContainer({
    super.key,
    required this.display,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SecretContainerViewModel(context),
      builder: (context, viewModel, child) => CustomButton(
        callback: () => viewModel.onCopyValue(value),
        widget: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: ThemeStyles.theme.primary300,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Icon(
                icon,
                color: ThemeStyles.theme.text300,
                size: 35,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      display,
                      style: ThemeStyles.regularParagraphOv(
                        size: 14,
                        color: ThemeStyles.theme.text300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.copy,
                color: ThemeStyles.theme.text300,
                size: 35,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
