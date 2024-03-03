import 'package:flutter/material.dart';
import 'package:presentation/views/add_otp_secret/add_otp_secret_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddOtpSecret extends StatelessWidget {
  const AddOtpSecret({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddOtpSecretViewModel(context),
      builder: (context, viewModel, child) => Placeholder(),
    );
  }
}
