import 'package:components/qr_scanner/qr_scanner_view.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/start_auth/start_auth_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartAuthView extends StatelessWidget {
  const StartAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => StartAuthViewModel(context),
      builder: (context, viewModel, child) => Container(
        width: ThemeStyles.width,
        height: ThemeStyles.height,
        child: QrScannerView(callback: viewModel.onScanComplete),
      ),
    );
  }
}
