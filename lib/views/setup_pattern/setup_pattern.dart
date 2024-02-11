import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:presentation/views/setup_pattern/setup_pattern_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SetupPattern extends StatelessWidget {
  const SetupPattern({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SetupPatternViewModel(context),
      builder: (context, viewModel, child) => Column(
        children: [
          NavMenuInner(
            location: "Setup pattern",
            callback: () => viewModel.router.backToPrevious(context),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.fromLTRB(16, 4, 16, 0),
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.background200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        viewModel.isConfirm
                            ? "Please confirm your pattern"
                            : "Set your lock pattern",
                        style: ThemeStyles.regularParagraph,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: ThemeStyles.height! / 2,
                        child: PatternLock(
                          selectedColor: ThemeStyles.theme.primary300,
                          pointRadius: 8,
                          showInput: true,
                          dimension: 3,
                          relativePadding: 0.7,
                          selectThreshold: 25,
                          fillPoints: true,
                          onInputComplete: (List<int> input) =>
                              viewModel.onPatternFilled(input),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
