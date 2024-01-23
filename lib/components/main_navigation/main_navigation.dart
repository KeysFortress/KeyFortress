import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/cloud_connection_status/cloud_connection_status.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/components/main_navigation/main_navigation_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MainNavigationViewModel(context),
      builder: (context, viewModel, child) => Container(
        padding: EdgeInsets.fromLTRB(6, 40, 0, 6),
        decoration: BoxDecoration(
          color: ThemeStyles.theme.primary300,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: CustomButton(
                callback: viewModel.onMenuPressed,
                widget: Container(
                  child: SvgPicture.asset(
                    "assets/images/menu.svg",
                    package: "domain",
                    width: 19.16,
                    height: 37.33,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      ThemeStyles.theme.accent100,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            CloudConnectionStatus(),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: CustomButton(
                callback: viewModel.onMenuPressed,
                widget: Container(
                  child: SvgPicture.asset(
                    "assets/images/sync.svg",
                    package: "domain",
                    width: 19.16,
                    height: 37.33,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      ThemeStyles.theme.accent100,
                      BlendMode.srcIn,
                    ),
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
