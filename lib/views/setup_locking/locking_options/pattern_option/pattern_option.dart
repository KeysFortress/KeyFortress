import 'package:flutter/material.dart';
import 'package:presentation/views/setup_locking/authentinication_type.dart';
import 'package:presentation/views/setup_locking/locking_options/pattern_option/pattern_option_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PatternOption extends StatelessWidget {
  const PatternOption({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PatternOptionViewModel(context),
      builder: (context, viewModel, child) => AuthentinicationType(
        heading: "Draw a Pattern",
        description:
            "Create a unique pattern to safeguard your digital space. Your personalized design becomes the key to seamless and protected access",
        images: [
          "assets/images/pattern.svg",
        ],
        onEnablePressed: viewModel.onEnabled,
      ),
    );
  }
}
