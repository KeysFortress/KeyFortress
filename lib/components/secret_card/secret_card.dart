import 'package:domain/models/stored_secret.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/components/password_strenght/password_strenght.dart';
import 'package:presentation/components/secret_card/secret_card.viewmodel.dart';
import 'package:stacked/stacked.dart';

class SecretCard extends StatelessWidget {
  final StoredSecret secret;
  const SecretCard({super.key, required this.secret});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SecretCardViewModel(context),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/website-password.svg',
                      package: 'domain',
                      width: 40,
                      height: 40,
                      colorFilter: ColorFilter.mode(
                        ThemeStyles.theme.primary300,
                        BlendMode.srcIn,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        secret.name,
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
                    initial: secret.content,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      secret.username,
                      style: ThemeStyles.regularParagraphOv(
                        size: 12,
                        color: ThemeStyles.theme.primary300,
                      ),
                    ),
                    Text(
                      "Last used: ${secret.lastUsed.day}/${secret.lastUsed.month}/${secret.lastUsed.year}",
                      style: ThemeStyles.regularParagraphOv(
                        size: 12,
                        color: ThemeStyles.theme.primary300,
                      ),
                    ),
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
