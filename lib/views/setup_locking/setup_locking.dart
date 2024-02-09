import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/setup_locking/setup_locking_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SetupLockingView extends StatelessWidget {
  const SetupLockingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SetupLockingViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Stack(
        children: [
          ListView.builder(
            physics: PageScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.lockOptions.length,
            itemBuilder: (context, index) {
              viewModel.updateScrollIndex(index);
              return viewModel.lockOptions.elementAt(index);
            },
          ),
          Positioned(
            height: 10,
            bottom: 10,
            width: ThemeStyles.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 96,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.lockOptions.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(2),
                      width: 20,
                      height: 5,
                      decoration: BoxDecoration(
                        color: viewModel.selectedOption == index
                            ? ThemeStyles.theme.primary100
                            : ThemeStyles.theme.primary300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
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
