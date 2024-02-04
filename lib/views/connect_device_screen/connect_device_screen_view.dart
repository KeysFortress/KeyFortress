import 'package:components/dashboard_header/dashboard_header.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
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
        color: ThemeStyles.theme.background300,
        child: Column(
          children: [
            DashboardHeader(
              icon: "secrets.svg",
              name: "Devices",
              type: ActiveNavigationPage.passwords,
              onNewPassword: viewModel.onConnectNewDevice,
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: viewModel.devices.length,
                itemBuilder: (context, index) => Placeholder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
