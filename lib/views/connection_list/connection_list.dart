import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_text_field/custom_text_field.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/views/connection_list/connection_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ConnectionListView extends StatelessWidget {
  const ConnectionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ConnectionListViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.background300,
        child: Column(
          children: [
            NavMenuInner(
              location: "Local Devices",
              callback: () => viewModel.router.backToPrevious(context),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: CustomTextField(
                borderRadius: 5,
                prefixIcon: Icon(
                  Icons.search,
                ),
                floatingLabel: "Search",
                onChange: viewModel.onSearchChanged,
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: viewModel.devices.length,
                itemBuilder: (context, index) => CustomButton(
                  callback: () => viewModel.onDeviceSelected(
                    viewModel.devices.elementAt(index),
                  ),
                  widget: Container(
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
                                    viewModel.devices.elementAt(index).ip,
                                    style: ThemeStyles.regularParagraphOv(
                                      color: ThemeStyles.theme.text300,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    viewModel.devices.elementAt(index).mac,
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
                                viewModel.getDeviceType(index),
                                package: "domain",
                                width: 40,
                                height: 80,
                                colorFilter: ColorFilter.mode(
                                  ThemeStyles.theme.primary300,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Text(
                                viewModel.devices.elementAt(index).name,
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
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
