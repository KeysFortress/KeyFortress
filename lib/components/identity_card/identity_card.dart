import 'package:domain/models/stored_identity.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/components/identity_card/identity_card.viewmodel.dart';
import 'package:presentation/components/password_strenght/password_strenght.dart';
import 'package:stacked/stacked.dart';

class IdentityCard extends StatelessWidget {
  final StoredIdentity identity;
  const IdentityCard({super.key, required this.identity});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => IdentityCardViewModel(context),
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
              right: 0,
              child: CustomButton(
                widget: SvgPicture.asset(
                  "assets/images/copy.svg",
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PasswordStrenght(
                    initial: identity.publicKey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   secret.username,
                    //   style: ThemeStyles.regularParagraphOv(
                    //     size: 12,
                    //     color: ThemeStyles.theme.primary300,
                    //   ),
                    // ),
                    // Text(
                    //   "Last used: ${secret.lastUsed.day}/${secret.lastUsed.month}/${secret.lastUsed.year}",
                    //   style: ThemeStyles.regularParagraphOv(
                    //     size: 12,
                    //     color: ThemeStyles.theme.primary300,
                    //   ),
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
