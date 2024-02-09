import 'package:flutter/material.dart';
import 'package:presentation/views/setup_locking/authentinication_type.dart';
import 'package:presentation/views/setup_locking/locking_options/totp_option/totp_option_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TotpOption extends StatelessWidget {
  const TotpOption({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TotpOptionViewModel(context),
      builder: (context, viewModel, child) => AuthentinicationType(
        heading: "Totp",
        description:
            "Enable Time-Based One-Time Passwords for an extra layer of protection. Dynamic codes that keep your account secure.  ",
        images: [
          "assets/images/totp-setup.svg",
        ],
        onEnablePressed: viewModel.onToTpEnabled,
      ),
    );
  }
}
