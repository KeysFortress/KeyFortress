import 'package:components/certificate_information/certificate_information.dart';
import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/custom_text_field/custom_text_field.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/pair_settings/pair_settings_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PairSettings extends StatelessWidget {
  const PairSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PairSettingsViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(
              child: NavMenuInner(
                callback: () => viewModel.router.backToPrevious(context),
                location: "Pair Settings",
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
                                    value: viewModel.pairEnabled,
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
                              child: CustomTextField(
                                floatingLabel: "Port",
                                hint: "22345",
                                controller: TextEditingController(
                                  text: viewModel.currentPort.toString(),
                                ),
                                onChange: viewModel.onPortNumberChanged,
                                restricted: TextInputType.number,
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
                                  CustomIconButton(
                                    label: "Update SSL Certificate",
                                    callback: viewModel.onUpdateCertificate,
                                    height: 50,
                                    buttonColor: ThemeStyles.theme.primary300,
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    floatingLabel: "Password",
                                    hint: "your amazing password",
                                    controller: TextEditingController(
                                      text: viewModel.oldPassword.toString(),
                                    ),
                                    onChange:
                                        viewModel.onPrivateKeyPasswordChanged,
                                  )
                                ],
                              ),
                            ),
                            if (viewModel.certificateData != null)
                              ...viewModel.certificateData!
                                  .map(
                                    (e) => CertificateInformation(e: e),
                                  )
                                  .toList()
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
