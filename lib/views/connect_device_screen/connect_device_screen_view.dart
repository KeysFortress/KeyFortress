import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/dashboard_header/dashboard_header.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/models/enums.dart';
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
        color: ThemeStyles.theme.background300,
        child: Column(
          children: [
            NavMenuInner(
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
            Container(
              margin: EdgeInsets.all(5),
              child: CustomIconButton(
                icon: Icon(
                  Icons.connect_without_contact,
                  color: ThemeStyles.theme.text300,
                ),
                label: "Add Connection",
                callback: () {},
                height: 50,
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: viewModel.devices.length,
                itemBuilder: (context, index) => Stack(
                  alignment: Alignment.center,
                  fit: StackFit.passthrough,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                      decoration: BoxDecoration(
                        color: ThemeStyles.theme.background200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/images/computer.svg",
                            package: "domain",
                            width: 40,
                            height: 80,
                            colorFilter: ColorFilter.mode(
                              ThemeStyles.theme.primary300,
                              BlendMode.srcIn,
                            ),
                          ),
                          Text(
                            viewModel.devices.elementAt(index).name,
                            style: ThemeStyles.innerHeadingOv(
                              color: ThemeStyles.theme.accent200,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 15,
                      child: Container(
                        width: 90,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ThemeStyles.theme.primary300,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              viewModel.devices.elementAt(index).isOnline
                                  ? "Online"
                                  : "Offline",
                              style: ThemeStyles.regularParagraphOv(
                                color: ThemeStyles.theme.text300,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    viewModel.devices.elementAt(index).isOnline
                                        ? ThemeStyles.theme.accent100
                                        : ThemeStyles.theme.background200,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 15,
                      child: Container(
                        width: 90,
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
                              "P Sync",
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
