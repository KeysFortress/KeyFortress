import 'package:flutter/material.dart';
import 'package:presentation/views/setup_pattern/setup_pattern_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SetupPattern extends StatelessWidget {
  const SetupPattern({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SetupPatternViewModel(context),
      builder: (context, viewModel, child) => Placeholder(),
    );
  }
}
