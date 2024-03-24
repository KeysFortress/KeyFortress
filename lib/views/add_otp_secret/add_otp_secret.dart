import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/custom_text_field/custom_text_field.dart';
import 'package:components/horizontal_divider/horizontal_divider.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:components/seconds_counter/seconds_counter.dart';
import 'package:components/topt_entry_box/totp_entry_box_viewmodel.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class AddOtpSecret extends StatelessWidget {
  const AddOtpSecret({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TotpEntryBoxViewModel(context, null),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Container(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(
              child: NavMenuInner(
                location: "",
                callback: () => viewModel.router.backToPrevious(context),
              ),
            ),
            Expanded(
              child: Container(
                color: ThemeStyles.theme.background300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                      decoration: BoxDecoration(
                        color: ThemeStyles.theme.background200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CustomTextField(
                        floatingLabel: "TOTP Link",
                        onChange: viewModel.onLinkChanged,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                      decoration: BoxDecoration(
                        color: ThemeStyles.theme.background200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Text(
                                viewModel.getCode(),
                                style: ThemeStyles.regularHeading,
                              ),
                              const HorizontalDivider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    viewModel.code == null
                                        ? "--"
                                        : viewModel.code!.address,
                                    style: ThemeStyles.regularParagraphOv(
                                      size: 12,
                                      color: ThemeStyles.theme.primary300,
                                    ),
                                  ),
                                  Text(
                                    viewModel.code == null
                                        ? "--"
                                        : viewModel.code!.issuer,
                                    style: ThemeStyles.regularParagraphOv(
                                      size: 12,
                                      color: ThemeStyles.theme.primary300,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          if (viewModel.code != null)
                            Positioned(
                              left: 10,
                              child: SecoondsCounter(
                                otpCode: viewModel.code!,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                      child: CustomIconButton(
                        buttonColor: ThemeStyles.theme.primary300,
                        height: 50,
                        label: "Save",
                        callback: viewModel.onSave,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
