import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/components/horizontal_divider/horizontal_divider.dart';
import 'package:presentation/components/nav_menu_inner/nav_menu_inner.dart';
import 'package:presentation/components/seconds_counter/seconds_counter.dart';
import 'package:presentation/views/totp/totp_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TotpView extends StatelessWidget {
  const TotpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TotpViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.background300,
        child: Column(
          children: [
            NavMenuInner(
              location: "TOTP",
              callback: () => viewModel.router.backToPrevious(context),
              button: CustomButton(
                callback: viewModel.onAddPressed,
                widget: SvgPicture.asset(
                  'assets/images/scan.svg',
                  package: 'domain',
                  colorFilter: ColorFilter.mode(
                    ThemeStyles.theme.accent100,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: viewModel.secrets.length,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.fromLTRB(16, 4, 16, 0),
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.background200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Text(
                            viewModel.getCode(
                              viewModel.secrets.elementAt(index),
                            ),
                            style: ThemeStyles.regularHeading,
                          ),
                          HorizontalDivider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                viewModel.secrets.elementAt(index).address,
                                style: ThemeStyles.regularParagraphOv(
                                  size: 12,
                                  color: ThemeStyles.theme.primary300,
                                ),
                              ),
                              Text(
                                viewModel.secrets.elementAt(index).issuer,
                                style: ThemeStyles.regularParagraphOv(
                                  size: 12,
                                  color: ThemeStyles.theme.primary300,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        left: 10,
                        child: SecoondsCounter(),
                      ),
                      Positioned(
                        right: 10,
                        child: CustomButton(
                          widget: SvgPicture.asset(
                            'assets/images/bin.svg',
                            package: 'domain',
                          ),
                          callback: () => viewModel.onDeletePressed(
                            viewModel.secrets.elementAt(index),
                          ),
                        ),
                      )
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
