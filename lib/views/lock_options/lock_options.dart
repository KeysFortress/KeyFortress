import 'package:components/custom_button/custom_button.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/lock_options/lock_options_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LockOptions extends StatelessWidget {
  const LockOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LockOptionsViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(
              child: NavMenuInner(
                callback: () => viewModel.router.backToPrevious(context),
                location: "Lock Options",
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
                                    value: viewModel.lockEnabled,
                                    activeColor: ThemeStyles.theme.primary300,
                                    onChanged: viewModel.onEnabledChanged,
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
                                          viewModel.lockTime.toString(),
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
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
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
                                        "Time based lock",
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
                                        value: viewModel.isTimeLockEnabled,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged:
                                            viewModel.onTimeBasedLockChanged,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Lock on minimized",
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
                                        value: viewModel.isMinimizeLockEnabled,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged:
                                            viewModel.onMinimizeLockChanged,
                                      )
                                    ],
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Biometric",
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
                                        value: viewModel.deviceLockType ==
                                            DeviceLockType.biometric,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged: viewModel.onEnabledBiometric,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Password",
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
                                        value: viewModel.deviceLockType ==
                                            DeviceLockType.password,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged: viewModel.onEnablePassword,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Pattern",
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
                                        value: viewModel.deviceLockType ==
                                            DeviceLockType.pattern,
                                        activeColor:
                                            ThemeStyles.theme.primary300,
                                        onChanged: viewModel.onEnabledPattern,
                                      )
                                    ],
                                  )
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
