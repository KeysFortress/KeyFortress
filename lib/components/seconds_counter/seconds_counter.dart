import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/seconds_counter/seconds_counter_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SecoondsCounter extends StatelessWidget {
  const SecoondsCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SecondsCounterViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeStyles.theme.accent100,
        ),
        child: Text(
          viewModel.seconds.toString(),
          style: ThemeStyles.regularParagraph,
        ),
      ),
    );
  }
}
