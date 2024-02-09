import 'package:flutter/material.dart';
import 'package:presentation/views/setup_locking/authentinication_type.dart';
import 'package:presentation/views/setup_locking/locking_options/biometric_option/biometric_option_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BiometricOption extends StatelessWidget {
  const BiometricOption({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BiometricOptionViewModel(context),
      builder: (context, viewModel, child) => AuthentinicationType(
        heading: "Biometric Authentication",
        description:
            "Enable biometric authentication for swift, hassle-free access every time you open the app. Your fingerprint or facial recognition becomes the key to maximum protection.",
        images: [
          "assets/images/face-id.svg",
          "assets/images/fingerprint.svg",
        ],
        onEnablePressed: viewModel.onEnabled,
      ),
    );
  }
}
