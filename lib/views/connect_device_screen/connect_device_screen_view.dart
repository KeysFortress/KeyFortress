import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:components/connected_device_card/connected_device_card.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                location: "Connected Devices",
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
                      label: "Add Connection",
                      callback: viewModel.onAddConnection,
                      height: 50,
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
