import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:components/connected_device_card/connected_device_card.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/views/connect_device_screen/connect_device_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ConnectDeviceScreenView extends StatelessWidget {
  const ConnectDeviceScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ConnectDeviceScreenViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(
              child: NavMenuInner(
                location: "Synchronization",
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
            ),
            Expanded(
                child: Container(
              color: ThemeStyles.theme.background300,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: CustomIconButton(
                      icon: Icon(
                        Icons.connect_without_contact,
                        color: ThemeStyles.theme.text300,
                      ),
                      label: "Wifi Connection",
                      callback: viewModel.onAddConnection,
                      height: 50,
                    ),
                  ),
                  if (viewModel.cloudConnections.length == 0)
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                      decoration: BoxDecoration(
                        color: ThemeStyles.theme.background200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(
                                "assets/images/cloud-not-connected.svg",
                                package: "domain",
                                width: 40,
                                height: 80,
                                colorFilter: ColorFilter.mode(
                                  ThemeStyles.theme.primary300,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Text(
                                "Cloud connection state",
                                style: ThemeStyles.innerHeadingOv(
                                  color: ThemeStyles.theme.accent200,
                                  fontSize: 18,
                                ),
                              ),
                              Divider(
                                height: 10,
                                thickness: 1,
                                color: ThemeStyles.theme.primary300,
                              ),
                              Text(
                                "Disconnected",
                                style: ThemeStyles.innerHeadingOv(
                                  color: ThemeStyles.theme.accent200,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (viewModel.cloudConnections.length > 0)
                    ...viewModel.cloudConnections.map(
                      (e) => Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                        decoration: BoxDecoration(
                          color: ThemeStyles.theme.background200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/cloud-connected.svg",
                                  package: "domain",
                                  width: 40,
                                  height: 80,
                                  colorFilter: ColorFilter.mode(
                                    ThemeStyles.theme.primary300,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Text(
                                  "Online",
                                  style: ThemeStyles.innerHeadingOv(
                                    color: ThemeStyles.theme.accent200,
                                    fontSize: 18,
                                  ),
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 1,
                                  color: ThemeStyles.theme.primary300,
                                ),
                                Text(
                                  "Connected",
                                  style: ThemeStyles.innerHeadingOv(
                                    color: ThemeStyles.theme.accent200,
                                    fontSize: 14,
                                  ),
                                ),
                                CustomIconButton(
                                  label: "Remote Authentication",
                                  callback: viewModel.onRemoteConnection,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: viewModel.devices.length,
                      itemBuilder: (context, index) => CustomButton(
                        callback: () => viewModel.onDeviceSelected(
                          viewModel.devices.elementAt(index),
                        ),
                        widget: ConnectedDeviceCard(
                          currentDevice: viewModel.devices.elementAt(index),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
