import 'package:components/horizontal_divider/horizontal_divider.dart';
import 'package:components/main_navigation/main_navigation.dart';
import 'package:components/secret_card/secret_card.dart';
import 'package:components/simple_toggle/simple_toggle.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/stored_secret.dart';
import 'package:domain/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/views/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:charts_painter/chart.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DashboardViewModel(context),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.background300,
        child: Column(
          children: [
            SafeArea(child: MainNavigation()),
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
                        [10, 5, 8, 2, 3, 6]
                            .map(
                              (e) => ChartItem<void>(
                                e.toDouble(),
                                value: "test",
                              ),
                            )
                            .toList(),
                      ),
                      itemOptions: BarItemOptions(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "10 Passwords",
                          style: ThemeStyles.regularParagraphOv(
                            color: ThemeStyles.theme.primary300,
                            size: 10,
                          ),
                        ),
                        Text(
                          "5 TOTP",
                          style: ThemeStyles.regularParagraphOv(
                            color: ThemeStyles.theme.primary300,
                            size: 10,
                          ),
                        ),
                        Text(
                          "8 Identities",
                          style: ThemeStyles.regularParagraphOv(
                            color: ThemeStyles.theme.primary300,
                            size: 10,
                          ),
                        ),
                        Text(
                          "2 RAC",
                          style: ThemeStyles.regularParagraphOv(
                            color: ThemeStyles.theme.primary300,
                            size: 10,
                          ),
                        ),
                        Text(
                          "3 RLC",
                          style: ThemeStyles.regularParagraphOv(
                            color: ThemeStyles.theme.primary300,
                            size: 10,
                          ),
                        ),
                        Text(
                          "3 Secrets",
                          style: ThemeStyles.regularParagraphOv(
                            color: ThemeStyles.theme.primary300,
                            size: 10,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: ThemeStyles.theme.background200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: viewModel.connectedDevices.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/computer.svg",
                            package: 'domain',
                            fit: BoxFit.contain,
                            height: 80,
                            colorFilter: ColorFilter.mode(
                              ThemeStyles.theme.primary300,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Oops. it appears that there are no nearby devices connected, please check if you're connected over wifi network as the device you're trying to reach.",
                            style: ThemeStyles.regularParagraphOv(
                              size: 12,
                              color: ThemeStyles.theme.primary300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Connected Devices",
                            style: ThemeStyles.regularParagraph,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 25,
                              itemBuilder: (context, index) => SecretCard(
                                secret: StoredSecret(
                                  id: "",
                                  name: "dawdwa",
                                  username: "",
                                  content: "",
                                  lastUsed: DateTime.now(),
                                  secretType: SecretType.password,
                                ),
                                copyEnabled: false,
                                onActionCallback: () {},
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            ),
            Expanded(
              child: Container(
                color: ThemeStyles.theme.background300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                      decoration: BoxDecoration(
                        color: ThemeStyles.theme.background200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "assets/images/website-password.svg",
                                  title: "Passwords",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "assets/images/timer.svg",
                                  title: "TOTP/OTP",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "assets/images/certificate.svg",
                                  title: "Identities",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "assets/images/rac.svg",
                                  title: "RAC",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "assets/images/rlc.svg",
                                  title: "RLC",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "assets/images/sync.svg",
                                  title: "Pair",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
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
