import 'package:flutter/material.dart';
import 'package:presentation/views/setup_locking/authentinication_type.dart';
import 'package:presentation/views/setup_locking/locking_options/pin_option/pin_option_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PinOption extends StatelessWidget {
  const PinOption({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PinOptionViewModel(context),
      builder: (context, viewModel, child) => AuthentinicationType(
        heading: "Pin number",
        description:
            " Set up a personalized PIN for quick and secure access to your app. It's your secret code to a protected digital world.",
        images: [
          "assets/images/lock.svg",
        ],
        onEnablePressed: viewModel.onEnabled,
      ),
    );
  }
}
