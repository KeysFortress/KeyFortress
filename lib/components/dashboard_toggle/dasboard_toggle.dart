import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:stacked/stacked.dart';
import 'package:domain/models/component_action.dart';

class DashboardToggle extends StatelessWidget {
  final ComponentActionViewModel viewModel;
  const DashboardToggle({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => viewModel,
      fireOnViewModelReadyOnce: true,
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => CustomButton(
        callback: viewModel.onPresssed,
        widget: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: viewModel.isActive
                ? ThemeStyles.theme.primary100
                : ThemeStyles.theme.primary300,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                viewModel.icon ?? "",
                package: "domain",
                width: 32,
                height: 32,
                colorFilter: ColorFilter.mode(
                  ThemeStyles.theme.text300,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                viewModel.title ?? "",
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.theme.text300,
                  size: 14,
                ),
                textAlign: TextAlign.center,
              ),
              if (viewModel.isActive ||
                  viewModel.statusMessage != null &&
                      viewModel.statusMessage!.isNotEmpty)
                Container(
                  margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    viewModel.statusMessage ?? "active".i18n(),
                    style: ThemeStyles.regularParagraphOv(
                      size: 12,
                      color: viewModel.defaultMessageColor ??
                          ThemeStyles.theme.text300,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
