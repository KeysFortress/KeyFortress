import 'package:components/custom_button/custom_button.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/sync_settings/sync_settings_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SyncSettings extends StatelessWidget {
  const SyncSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SyncSettingsViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(
              child: NavMenuInner(
                callback: () => viewModel.router.backToPrevious(context),
                location: "Sync Settings",
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
                                    "These rules don't apply to devices that override these settings from the device page.",
                                    style: ThemeStyles.regularParagraphOv(
                                      color: ThemeStyles.theme.primary300,
                                      size: 14,
                                    ),
                                  ),
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
                                    "Enabled",
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
                                    value: viewModel.enabled,
                                    activeColor: ThemeStyles.theme.primary300,
                                    onChanged: viewModel.onSyncStateChanged,
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
                              child: Column(
                                children: [
                                  Text(
                                    "Synchronize each time an action is taken, for example adding a new password, secret, identity, remote access controller or remote login controller",
                                    style: ThemeStyles.regularParagraphOv(
                                      color: ThemeStyles.theme.primary300,
                                      size: 14,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sync on action",
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
                                        value: viewModel.syncOnAction,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged:
                                            viewModel.onSyncOnActionChanged,
                                      )
                                    ],
                                  ),
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
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "After a password action",
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
                                        value: viewModel
                                            .afterPasswordActionEnabled,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged: viewModel
                                            .onAfterPasswordActionChanged,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "After an identity action",
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
                                        value: viewModel
                                            .onAfterIdentityActionEnabled,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged:
                                            viewModel.onAfterIdentityChanged,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "After a secret action",
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
                                        value: viewModel
                                            .onAfterSecretActionEnabled,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged:
                                            viewModel.onAfterSecretAction,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "After an RLC configuration",
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
                                        value:
                                            viewModel.onAfterRlcActionEnabled,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged:
                                            viewModel.onAfterRlcActionChanged,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "After an RAC configuration ",
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
                                        value:
                                            viewModel.onAfterRacActionEnabled,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged:
                                            viewModel.onAfterRacActionChanged,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "After a OTP/TOTP action",
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
                                        value:
                                            viewModel.onAfterTotpActionEnabled,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged:
                                            viewModel.onAfteToTpActinChanged,
                                      )
                                    ],
                                  ),
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
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sync on connection",
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
                                        value:
                                            viewModel.onSyncOnConnectionEnabled,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged: viewModel
                                            .onSyncOnCoonnectionChanged,
                                      )
                                    ],
                                  ),
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
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Time based synchronization",
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
                                        value: viewModel.onTimeBasedEnabled,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged:
                                            viewModel.onTimeBasedActionChanged,
                                      )
                                    ],
                                  ),
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
                                          viewModel.syncTime.toString(),
                                          style: ThemeStyles.regularParagraphOv(
                                            size: 32,
                                            color: ThemeStyles.theme.primary300,
                                          ),
                                        ),
                                        Text(
                                          "Seconds",
                                          style: ThemeStyles.regularParagraphOv(
                                            size: 16,
                                            color: ThemeStyles.theme.primary300,
                                          ),
                                        )
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
                                              color:
                                                  ThemeStyles.theme.primary300,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              color:
                                                  ThemeStyles.theme.accent100,
                                              size: 16,
                                            ),
                                          ),
                                          callback: viewModel.onSubstractTime,
                                        ),
                                        Text(
                                          "15 seconds",
                                          style: ThemeStyles.regularParagraphOv(
                                            color: ThemeStyles.theme.primary200,
                                            size: 16,
                                          ),
                                        ),
                                        CustomButton(
                                          widget: Container(
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color:
                                                  ThemeStyles.theme.primary300,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color:
                                                  ThemeStyles.theme.accent100,
                                              size: 16,
                                            ),
                                          ),
                                          callback: viewModel.onIncrementTime,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
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
