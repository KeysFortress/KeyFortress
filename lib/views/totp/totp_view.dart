import 'package:components/custom_button/custom_button.dart';
import 'package:components/dashboard_toggle/dasboard_toggle.dart';
import 'package:components/horizontal_divider/horizontal_divider.dart';
import 'package:components/main_navigation/main_navigation.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:components/navigation_menu/navigation_menu.dart';
import 'package:components/seconds_counter/seconds_counter.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/views/totp/totp_viewmodel.dart';
import 'package:shared/base_component_toggle.dart';
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
            MainNavigation(),
            const SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: DashboardToggle(
                      height: 100,
                      viewModel: BaseComponentToggle(
                        context,
                        "assets/images/scan.svg",
                        "Scan QR Code",
                        viewModel.onScanPressed,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DashboardToggle(
                      height: 100,
                      viewModel: BaseComponentToggle(
                        context,
                        "assets/images/add-square.svg",
                        "Add Secret",
                        viewModel.onAddPressed,
                      ),
                    ),
                  )
                ],
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
            NavigationMenu(
              currentPage: ActiveNavigationPage.totp,
            )
          ],
        ),
      ),
    );
  }
}
