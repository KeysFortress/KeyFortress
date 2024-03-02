import 'package:components/custom_button/custom_button.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/device/device_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:components/dashboard_toggle/dasboard_toggle.dart';
import 'package:shared/base_component_toggle.dart';

class DeviceView extends StatelessWidget {
  const DeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DeviceViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.background300,
        child: Column(
          children: [
            NavMenuInner(
              location: viewModel.deviceName,
              callback: () => viewModel.router.backToPrevious(context),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DashboardToggle(
                  height: 100,
                  viewModel: BaseComponentToggle(
                    context,
                    "assets/images/sync.svg",
                    "Full Sync",
                    viewModel.fullSyncPreessed,
                  ),
                ),
                DashboardToggle(
                  height: 100,
                  viewModel: BaseComponentToggle(
                    context,
                    "assets/images/partial-sync.svg",
                    "Partial Sync",
                    () {},
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(4),
              child: DashboardToggle(
                width: double.infinity,
                height: 100,
                viewModel: BaseComponentToggle(
                  context,
                  "assets/images/one-time-sync.svg",
                  "One time connection",
                  () {},
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(4, 4, 4, 8),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: ThemeStyles.theme.background100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "Connection History",
                style: ThemeStyles.regularHeading,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) => Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                    decoration: BoxDecoration(
                      color: ThemeStyles.theme.background200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Transaction public key",
                          style: ThemeStyles.regularInnerHeading,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.public,
                              color: ThemeStyles.theme.primary300,
                              size: 35,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "dawdawd awd d awd ad wad ad ",
                              style: ThemeStyles.regularParagraphOv(
                                color: ThemeStyles.theme.primary300,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: ThemeStyles.theme.primary300,
                                  size: 35,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "10/05/2024",
                                  style: ThemeStyles.regularParagraphOv(
                                    color: ThemeStyles.theme.primary300,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "12:24",
                              style: ThemeStyles.regularParagraphOv(
                                color: ThemeStyles.theme.primary300,
                              ),
                            )
                          ],
                        ),
                        CustomButton(
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_downward,
                                color: ThemeStyles.theme.accent200,
                                size: 15,
                              ),
                              Text(
                                "View Details",
                                style: ThemeStyles.regularParagraph,
                              )
                            ],
                          ),
                          callback: () {},
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 4,
                    left: 8,
                    child: Container(
                      width: 120,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ThemeStyles.theme.primary300,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          topLeft: Radius.circular(4),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.connect_without_contact,
                            size: 20,
                            color: ThemeStyles.theme.text300,
                          ),
                          Text(
                            "OTC Sync",
                            style: ThemeStyles.regularParagraphOv(
                              color: ThemeStyles.theme.text300,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
