import 'package:domain/models/stored_identity.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/components/custom_icon_button/custom_icon_button.dart';
import 'package:presentation/components/identity_card/identity_card.viewmodel.dart';
import 'package:stacked/stacked.dart';

class IdentityCard extends StatelessWidget {
  final StoredIdentity identity;
  const IdentityCard({super.key, required this.identity});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => IdentityCardViewModel(context, identity),
      builder: (context, viewModel, child) => Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.fromLTRB(16, 4, 16, 0),
        decoration: BoxDecoration(
          color: ThemeStyles.theme.background200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: CustomButton(
                widget: SvgPicture.asset(
                  "assets/images/history.svg",
                  package: 'domain',
                  width: 20,
                  height: 20,
                ),
                callback: () {},
              ),
            ),
            Positioned(
              right: 0,
              child: CustomButton(
                widget: SvgPicture.asset(
                  "assets/images/scan.svg",
                  package: 'domain',
                  width: 20,
                  height: 20,
                ),
                callback: () {},
              ),
            ),
            Column(
              children: [
                SvgPicture.asset(
                  'assets/images/certificate.svg',
                  package: 'domain',
                  width: 90,
                  height: 90,
                  colorFilter: ColorFilter.mode(
                    ThemeStyles.theme.primary300,
                    BlendMode.srcIn,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        identity.name,
                        style: ThemeStyles.regularParagraphOv(
                          size: 16,
                          color: ThemeStyles.theme.primary300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.primary300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Icon(
                        Icons.public,
                        color: ThemeStyles.theme.text300,
                        size: 35,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              identity.publicKey,
                              style: ThemeStyles.regularParagraphOv(
                                size: 14,
                                color: ThemeStyles.theme.text300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.copy,
                        color: ThemeStyles.theme.text300,
                        size: 35,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.primary300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Icon(
                        Icons.privacy_tip_outlined,
                        color: ThemeStyles.theme.text300,
                        size: 35,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              "*********************************",
                              style: ThemeStyles.regularParagraphOv(
                                size: 14,
                                color: ThemeStyles.theme.text300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.copy,
                        color: ThemeStyles.theme.text300,
                        size: 35,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      height: 40,
                      expand: true,
                      label: "Sign",
                      callback: viewModel.onConnectPressed,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
