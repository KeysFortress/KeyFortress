import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/setup_locking/setup_locking_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SetupLockingView extends StatelessWidget {
  const SetupLockingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SetupLockingViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.lockOptions.length,
        itemBuilder: (context, index) => viewModel.lockOptions.elementAt(index),
      ),
    );
  }
}
