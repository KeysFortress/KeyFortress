import 'package:flutter/material.dart';
import 'package:presentation/views/setup_locking/authentinication_type.dart';
import 'package:shared/page_view_model.dart';

class SetupLockingViewModel extends PageViewModel {
  List<Widget> _lockOptions = [
    AuthentinicationType(
      heading: "Biometric Authentication",
      description:
          "Enable biometric authentication for swift, hassle-free access every time you open the app. Your fingerprint or facial recognition becomes the key to maximum protection.",
      images: [
        "assets/images/face-id.svg",
        "assets/images/fingerprint.svg",
      ],
    ),
    AuthentinicationType(
      heading: "Pin number",
      description:
          " Set up a personalized PIN for quick and secure access to your app. It's your secret code to a protected digital world.",
      images: [
        "assets/images/lock.svg",
      ],
    ),
    AuthentinicationType(
      heading: "Pin number",
      description:
          "Create a unique pattern to safeguard your digital space. Your personalized design becomes the key to seamless and protected access",
      images: [
        "assets/images/pattern.svg",
      ],
    ),
    AuthentinicationType(
      heading: "Pin number",
      description:
          "Enable Time-Based One-Time Passwords for an extra layer of protection. Dynamic codes that keep your account secure.  ",
      images: [
        "assets/images/totp-setup.svg",
      ],
    ),
  ];
  List<Widget> get lockOptions => _lockOptions;

  SetupLockingViewModel(super.context);

  ready() {}
}
