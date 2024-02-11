import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/custom_text_field/custom_text_field.dart';
import 'package:components/qr_scanner/qr_scanner_view.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/setup_totp_lock/setup_totp_lock_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SetupTotpLock extends StatelessWidget {
  const SetupTotpLock({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SetupTotpLockViewModel(context),
      builder: (context, viewModel, child) => Stack(
        children: [
          Container(
            width: ThemeStyles.width,
            height: ThemeStyles.height,
            child: QrScannerView(callback: viewModel.onScanComplete),
          ),
          Positioned(
            bottom: 0,
            width: ThemeStyles.width,
            child: Container(
              height: 160,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: ThemeStyles.theme.background200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  CustomTextField(
                    floatingLabel: "Secret",
                    onChange: viewModel.onSecretChanged,
                  ),
                  const SizedBox(height: 8),
                  CustomIconButton(
                    height: 50,
                    label: "Save Changes",
                    callback: viewModel.onSaveChanges,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
