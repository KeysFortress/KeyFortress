import 'package:components/main_navigation/main_navigation.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/views/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:charts_painter/chart.dart';
import 'package:components/keyboard_menu/keyboard_menu.dart';
import 'package:components/connected_devices_carousel/connected_devices_carousel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DashboardViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.background300,
        child: Column(
          children: [
            SafeArea(child: MainNavigation()),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: ThemeStyles.theme.background200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        children: [
                          Chart(
                            state: ChartState<void>(
                              data: ChartData.fromList(
                                [
                                  viewModel.secrets,
                                  viewModel.optSecrets,
                                  viewModel.identities,
                                  viewModel.rac,
                                  viewModel.rlc,
                                  viewModel.personalSecrets,
                                ]
                                    .map(
                                      (e) => ChartItem<void>(
                                        e.toDouble(),
                                        value: "test",
                                      ),
                                    )
                                    .toList(),
                              ),
                              itemOptions: BarItemOptions(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                barItemBuilder: (_) => BarItem(
                                  color: ThemeStyles.theme.primary300,
                                ),
                              ),
                              foregroundDecorations: [],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: ThemeStyles.theme.primary300,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/website-password.svg",
                                  package: 'domain',
                                  width: 16,
                                  colorFilter: ColorFilter.mode(
                                    ThemeStyles.theme.primary300,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/images/timer.svg",
                                  package: 'domain',
                                  width: 16,
                                  colorFilter: ColorFilter.mode(
                                    ThemeStyles.theme.primary300,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/images/certificate.svg",
                                  package: 'domain',
                                  width: 16,
                                  colorFilter: ColorFilter.mode(
                                    ThemeStyles.theme.primary300,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/images/rac.svg",
                                  package: 'domain',
                                  width: 16,
                                  colorFilter: ColorFilter.mode(
                                    ThemeStyles.theme.primary300,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/images/rlc.svg",
                                  package: 'domain',
                                  width: 16,
                                  colorFilter: ColorFilter.mode(
                                    ThemeStyles.theme.primary300,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/images/secrets_fill.svg",
                                  package: 'domain',
                                  width: 16,
                                  colorFilter: ColorFilter.mode(
                                    ThemeStyles.theme.primary300,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      child: ConnectedDevicesCarousel(),
                    ),
                    KeyboardMenu()
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
