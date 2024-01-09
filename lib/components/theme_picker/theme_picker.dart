import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/theme_picker/theme_picker_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ThemePicker extends StatelessWidget {
  const ThemePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ThemePickerViewModel(context),
        onViewModelReady: (viewModel) => viewModel.ready(),
        builder: (context, viewModel, child) => Slider(
              inactiveColor: Colors.black,
              value: viewModel.activeTheme,
              divisions: 2,
              max: 2,
              onChanged: viewModel.onThemeChanged,
              label: viewModel.themeName,
              activeColor: viewModel.themeColor,
              secondaryActiveColor: ThemeStyles.theme.background100,
              overlayColor: MaterialStatePropertyAll(
                ThemeStyles.theme.background100,
              ),
            ));
  }
}
