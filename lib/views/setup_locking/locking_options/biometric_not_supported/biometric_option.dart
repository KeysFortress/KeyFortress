import 'package:flutter/material.dart';
import 'package:presentation/views/setup_locking/authentinication_type.dart';

class BiometricNotSupported extends StatelessWidget {
  const BiometricNotSupported({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthentinicationType(
      hideBtn: true,
      heading: "Biometric Authentication",
      description: "Biometric is not supported on this device!",
      images: [
        "assets/images/face-id.svg",
        "assets/images/fingerprint.svg",
      ],
      onEnablePressed: () {},
    );
  }
}
