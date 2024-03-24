import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/settings/settings_viewmodel.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SettingsViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(
              child: NavMenuInner(
                callback: () => viewModel.router.backToPrevious(context),
                location: "Settings",
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: ThemeStyles.theme.background300,
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        decoration: BoxDecoration(
                          color: ThemeStyles.theme.background200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            CustomButton(
                              callback: viewModel.onQrPressed,
                              widget: QrImageView(
                                data: viewModel.getConnectionString,
                                size: viewModel.isQrPressed
                                    ? null
                                    : ThemeStyles.height! / 5,
                                eyeStyle: QrEyeStyle(
                                  color: ThemeStyles.theme.primary300,
                                  eyeShape: QrEyeShape.square,
                                ),
                                foregroundColor: ThemeStyles.theme.primary300,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone_android_rounded,
                                      color: ThemeStyles.theme.primary300,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Name: ",
                                      style: ThemeStyles.regularHeading,
                                    ),
                                  ],
                                ),
                                Text(
                                  viewModel.deviceName,
                                  style: ThemeStyles.regularHeading,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.wifi,
                                      color: ThemeStyles.theme.primary300,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Local address: ",
                                      style: ThemeStyles.regularHeading,
                                    ),
                                  ],
                                ),
                                Text(
                                  viewModel.localAddress,
                                  style: ThemeStyles.regularHeading,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomIconButton(
                              label: "Device",
                              callback: viewModel.onDeviceSettingPressed,
                              height: 50,
                              buttonColor: ThemeStyles.theme.primary300,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        decoration: BoxDecoration(
                          color: ThemeStyles.theme.background200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            CustomIconButton(
                              label: "Synchronization",
                              callback: viewModel.onSyncPressed,
                              height: 50,
                              buttonColor: ThemeStyles.theme.primary300,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomIconButton(
                              label: "Pair Settings",
                              callback: viewModel.onPairSettingPressing,
                              height: 50,
                              buttonColor: ThemeStyles.theme.primary300,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomIconButton(
                              label: "Autofill settings",
                              callback: viewModel.onAutoFillPressed,
                              height: 50,
                              buttonColor: ThemeStyles.theme.primary300,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomIconButton(
                              label: "Lock options",
                              callback: viewModel.onLockOptionsPressed,
                              height: 50,
                              buttonColor: ThemeStyles.theme.primary300,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        decoration: BoxDecoration(
                          color: ThemeStyles.theme.background200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "V0_0_8-Alpha",
                                  style: ThemeStyles.regularParagraphOv(
                                    color: ThemeStyles.theme.primary300,
                                    size: 16,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
