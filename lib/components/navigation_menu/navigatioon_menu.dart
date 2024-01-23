import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/custom_icon_button/custom_icon_button.dart';
import 'package:presentation/components/navigation_menu/navigation_menu.viewmodel.dart';
import 'package:stacked/stacked.dart';

class NavigationMenu extends StatelessWidget {
  final Function onPageChanged;

  const NavigationMenu({super.key, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NavigationMenuViewModel(context),
      builder: (context, viewModel, child) => Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomIconButton(
              buttonColor: ThemeStyles.theme.primary300,
              btnRadius: 0,
              expand: true,
              icon: SvgPicture.asset(
                "assets/images/website-password.svg",
                package: 'domain',
                width: 50,
                colorFilter: ColorFilter.mode(
                  viewModel.selected == ActiveNavigationPage.passwords
                      ? ThemeStyles.theme.accent100
                      : ThemeStyles.theme.accent200,
                  BlendMode.srcIn,
                ),
              ),
              label: "",
              callback: () {
                onPageChanged.call(ActiveNavigationPage.passwords);
                viewModel.onPasswordsPressed();
              },
            ),
            CustomIconButton(
              buttonColor: ThemeStyles.theme.primary300,
              btnRadius: 0,
              expand: true,
              icon: SvgPicture.asset(
                "assets/images/timer.svg",
                package: 'domain',
                colorFilter: ColorFilter.mode(
                  viewModel.selected == ActiveNavigationPage.syncMode
                      ? ThemeStyles.theme.accent100
                      : ThemeStyles.theme.accent200,
                  BlendMode.srcIn,
                ),
                width: 50,
              ),
              label: "",
              callback: viewModel.onTotpPressed,
            ),
            CustomIconButton(
              buttonColor: ThemeStyles.theme.primary300,
              btnRadius: 0,
              expand: true,
              icon: SvgPicture.asset(
                "assets/images/certificate.svg",
                package: 'domain',
                colorFilter: ColorFilter.mode(
                  viewModel.selected == ActiveNavigationPage.identities
                      ? ThemeStyles.theme.accent100
                      : ThemeStyles.theme.accent200,
                  BlendMode.srcIn,
                ),
                width: 50,
              ),
              label: "",
              callback: () {
                onPageChanged.call(ActiveNavigationPage.identities);
                viewModel.onCertificatesPressed();
              },
            )
          ],
        ),
      ),
    );
  }
}
