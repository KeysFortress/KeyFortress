import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/auto_fill_setting/auto_fill_setting_viewmodel.dart';
import 'package:stacked/stacked.dart';

class Autofill extends StatelessWidget {
  const Autofill({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AutoFillSettingViewModel(context),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(
              child: NavMenuInner(
                callback: () => viewModel.router.backToPrevious(context),
                location: "Auto Fill Setting",
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
                                    "Autofill Enabled",
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
                                    value: viewModel.autoFillEnabled,
                                    activeColor: ThemeStyles.theme.primary300,
                                    onChanged: viewModel.onAutoFillEnabled,
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
                                    "Passkey auto fill enabled",
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
                                    value: viewModel.passkeyAutoFill,
                                    activeColor: ThemeStyles.theme.primary300,
                                    onChanged:
                                        viewModel.onPassKeyAutoFillEnabled,
                                  )
                                ],
                              ),
                            ),
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
