import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_text_field/custom_text_field.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/device_setting/device_setting_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DeviceSetting extends StatelessWidget {
  const DeviceSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DeviceSettingViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(
              child: NavMenuInner(
                callback: () => viewModel.router.backToPrevious(context),
                location: "Device Setting",
              ),
            ),
            Expanded(
              child: Container(
                color: ThemeStyles.theme.background300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: ThemeStyles.width,
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              decoration: BoxDecoration(
                                color: ThemeStyles.theme.background200,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: TextEditingController(
                                        text: viewModel.deviceName,
                                      ),
                                      floatingLabel: "Device Name",
                                      onChange: viewModel.onDeviceNameChanged,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: ThemeStyles.width,
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              decoration: BoxDecoration(
                                color: ThemeStyles.theme.background200,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Self destruct",
                                    style: ThemeStyles.regularParagraphOv(
                                      color: ThemeStyles.theme.primary200,
                                      size: 16,
                                    ),
                                  ),
                                  Switch(
                                    inactiveThumbColor:
                                        ThemeStyles.theme.primary100,
                                    inactiveTrackColor:
                                        ThemeStyles.theme.primary300,
                                    value: viewModel.isSelfDestructEnabled,
                                    activeColor: ThemeStyles.theme.primary300,
                                    onChanged:
                                        viewModel.onSelfDestructStateChanged,
                                  )
                                ],
                              ),
                            ),
                            if (viewModel.isSelfDestructEnabled)
                              Container(
                                width: ThemeStyles.width,
                                padding: const EdgeInsets.all(12),
                                margin:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                decoration: BoxDecoration(
                                  color: ThemeStyles.theme.background200,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(32),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: ThemeStyles.theme.primary300,
                                          width: 5,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            viewModel.totalAttempts.toString(),
                                            style:
                                                ThemeStyles.regularParagraphOv(
                                              size: 32,
                                              color:
                                                  ThemeStyles.theme.primary300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 32, right: 32),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomButton(
                                            widget: Container(
                                              padding: EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: ThemeStyles
                                                    .theme.primary300,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                color:
                                                    ThemeStyles.theme.accent100,
                                                size: 16,
                                              ),
                                            ),
                                            callback:
                                                viewModel.onSubstractAttempt,
                                          ),
                                          Text(
                                            "1 attempt",
                                            style:
                                                ThemeStyles.regularParagraphOv(
                                              color:
                                                  ThemeStyles.theme.primary200,
                                              size: 16,
                                            ),
                                          ),
                                          CustomButton(
                                            widget: Container(
                                              padding: EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: ThemeStyles
                                                    .theme.primary300,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color:
                                                    ThemeStyles.theme.accent100,
                                                size: 16,
                                              ),
                                            ),
                                            callback:
                                                viewModel.onIncrementAttepmt,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            if (viewModel.isSelfDestructEnabled)
                              Container(
                                width: ThemeStyles.width,
                                padding: const EdgeInsets.all(12),
                                margin:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                decoration: BoxDecoration(
                                  color: ThemeStyles.theme.background200,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Attention:",
                                      style: ThemeStyles.regularParagraphOv(
                                        color: ThemeStyles.theme.primary200,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Please be aware that entering the wrong authentication method multiple times may result in the destruction of data stored on your device. This security measure is in place to protect your sensitive information from unauthorized access.",
                                      style: ThemeStyles.regularParagraphOv(
                                        color: ThemeStyles.theme.primary300,
                                        size: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "We highly recommend verifying your credentials carefully to prevent accidental data loss. If you are experiencing issues with authentication or need assistance, please reach out to our support team for guidance.",
                                      style: ThemeStyles.regularParagraphOv(
                                        color: ThemeStyles.theme.primary300,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (!viewModel.isSelfDestructEnabled)
                              Container(
                                width: ThemeStyles.width,
                                padding: const EdgeInsets.all(12),
                                margin:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                decoration: BoxDecoration(
                                  color: ThemeStyles.theme.background200,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Attention:",
                                      style: ThemeStyles.regularParagraphOv(
                                        color: ThemeStyles.theme.primary200,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Ensuring the security of your device is paramount to safeguarding your personal information and privacy. As an additional layer of protection, we highly recommend enabling the security setting to safeguard your data in case someone gains physical access to your device.",
                                      style: ThemeStyles.regularParagraphOv(
                                        color: ThemeStyles.theme.primary300,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
