import 'package:components/qr_scanner/qr_scanner_view.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/add_otp_code/add_otp_code_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddOtpCodeView extends StatelessWidget {
  const AddOtpCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddOtpCodeViewModel(context),
      builder: (context, viewModel, child) => Container(
        width: ThemeStyles.width,
        height: ThemeStyles.height,
        child: QrScannerView(callback: viewModel.onScanComplete),
      ),
    );
  }
}
