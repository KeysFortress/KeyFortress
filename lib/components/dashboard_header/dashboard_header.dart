import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/custom_icon_button/custom_icon_button.dart';
import 'package:presentation/components/dashboard_header/dashboard_header.viewmodel.dart';
import 'package:stacked/stacked.dart';

class DashboardHeader extends StatelessWidget {
  final Function onNewPassword;
  final ActiveNavigationPage type;

  const DashboardHeader({
    super.key,
    required this.onNewPassword,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DashboardHeaderViewModel(context),
      builder: (context, viewModel, child) => Container(
        width: double.infinity,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ThemeStyles.theme.primary300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  type == ActiveNavigationPage.passwords
                      ? "assets/images/shield.svg"
                      : "assets/images/certificate.svg",
                  package: 'domain',
                  width: 80,
                  colorFilter: ColorFilter.mode(
                    ThemeStyles.theme.accent100,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${viewModel.saved} ${type == ActiveNavigationPage.passwords ? "Passwords" : "Certificates"}",
                      style: ThemeStyles.regularParagraphOv(
                        size: 23,
                        color: ThemeStyles.theme.accent100,
                      ),
                    ),
                    Text(
                      "Last used: ",
                      style: ThemeStyles.regularParagraphOv(
                        size: 19,
                        color: ThemeStyles.theme.accent100,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              margin: EdgeInsets.all(8),
              child: CustomIconButton(
                expand: false,
                icon: SvgPicture.asset(
                  'assets/images/engine.svg',
                  package: 'domain',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    ThemeStyles.theme.primary300,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Generate new",
                callback: () {
                  onNewPassword.call();
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
