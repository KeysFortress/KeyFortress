import 'package:flutter/material.dart';
import 'package:presentation/views/initialization_page/intialization_viewmodel.dart';
import 'package:stacked/stacked.dart';

class InitializationView extends StatelessWidget {
  const InitializationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => InitializationViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Column(),
    );
  }
}
