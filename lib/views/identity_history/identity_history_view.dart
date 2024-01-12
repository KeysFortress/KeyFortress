import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:presentation/components/nav_menu_inner/nav_menu_inner.dart';
import 'package:presentation/components/secret_container/secret_container.dart';
import 'package:presentation/views/identity_history/identity_history_viewmodel.dart';
import 'package:stacked/stacked.dart';

class IdentityHistoryView extends StatelessWidget {
  const IdentityHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => IdentityHistoryViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.background300,
        child: Column(
          children: [
            NavMenuInner(
              location: viewModel.identity.name,
              callback: () => viewModel.router.backToPrevious(context),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: viewModel.events.length,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.fromLTRB(16, 4, 16, 0),
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.background200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/cpu.svg',
                        package: 'domain',
                        width: 90,
                        height: 90,
                        colorFilter: ColorFilter.mode(
                          ThemeStyles.theme.primary300,
                          BlendMode.srcIn,
                        ),
                      ),
                      if (viewModel.events.elementAt(index).url != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                viewModel.events.elementAt(index).url!,
                                style: ThemeStyles.regularParagraphOv(
                                  size: 16,
                                  color: ThemeStyles.theme.primary300,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      const SizedBox(height: 8),
                      Text(
                        "Message",
                        style: ThemeStyles.regularInnerHeading,
                      ),
                      SecretContainer(
                        display: viewModel.events.elementAt(index).message,
                        icon: Icons.message,
                        value: viewModel.events.elementAt(index).message,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Signature",
                        style: ThemeStyles.regularInnerHeading,
                      ),
                      SecretContainer(
                        display: "*************************************",
                        icon: Icons.fingerprint,
                        value: viewModel.events.elementAt(index).signature,
                      )
                    ],
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
