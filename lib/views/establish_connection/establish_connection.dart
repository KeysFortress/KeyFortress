import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/views/establish_connection/establish_connection_viewmodel.dart';
import 'package:stacked/stacked.dart';

class EstablishConnectionView extends StatelessWidget {
  const EstablishConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EstablishConnectionViewModel(context),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.background300,
        child: Column(
          children: [
            NavMenuInner(
              location: "Establish Connection",
              callback: () => viewModel.router.backToPrevious(context),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              decoration: BoxDecoration(
                color: ThemeStyles.theme.background200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: ThemeStyles.theme.primary300,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.private_connectivity_rounded,
                              size: 20,
                              color: ThemeStyles.theme.text300,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "192.168.1.108:34523",
                              style: ThemeStyles.regularParagraphOv(
                                color: ThemeStyles.theme.text300,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "00-B0-D0-63-C2-26",
                              style: ThemeStyles.regularParagraphOv(
                                color: ThemeStyles.theme.text300,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.laptop_mac,
                              size: 20,
                              color: ThemeStyles.theme.text300,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
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
                          "Workstation",
                          style: ThemeStyles.innerHeadingOv(
                            color: ThemeStyles.theme.accent200,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: BoxDecoration(
                color: ThemeStyles.theme.background200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/phone.svg",
                        package: "domain",
                        width: 40,
                        height: 80,
                        colorFilter: ColorFilter.mode(
                          ThemeStyles.theme.primary300,
                          BlendMode.srcIn,
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/images/sync.svg",
                        package: "domain",
                        width: 40,
                        height: 40,
                        colorFilter: ColorFilter.mode(
                          ThemeStyles.theme.primary300,
                          BlendMode.srcIn,
                        ),
                      ),
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
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Establishing connection...",
                    style: ThemeStyles.regularParagraph,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              decoration: BoxDecoration(
                color: ThemeStyles.theme.background200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Text(
                    "Please make sure the symbols match with the other deice",
                    style: ThemeStyles.regularParagraph,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: viewModel.pairCode.characters
                        .map(
                          (e) => SvgPicture.asset(
                            "assets/images/a$e.svg",
                            package: "domain",
                            width: 50,
                            height: 50,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.fromLTRB(16, 4, 16, 0),
              decoration: BoxDecoration(
                color: ThemeStyles.theme.background200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
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
                          "Handshake request handler",
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
                    padding: const EdgeInsets.all(6),
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
                                "awdk=dwaddawd-dawdawd-awd-ddwa",
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: CustomIconButton(
                height: 50,
                label: "Pair",
                callback: viewModel.onPairPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
