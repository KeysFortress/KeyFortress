import 'package:components/main_navigation/main_navigation.dart';
import 'package:components/simple_toggle/simple_toggle.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DashboardViewModel(context),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.background300,
        child: Column(
          children: [
            SafeArea(child: MainNavigation()),
            Expanded(
              child: Container(
                color: ThemeStyles.theme.background300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "assets/images/website-password.svg",
                                  title: "Passwords",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "assets/images/timer.svg",
                                  title: "TOTP/OTP",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "assets/images/certificate.svg",
                                  title: "Identities",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "",
                                  title: "RAC",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "",
                                  title: "RLC",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SimpleToggle(
                                  height: 120,
                                  width: double.infinity,
                                  icon: "assets/images/sync.svg",
                                  title: "Connect",
                                  isActive: false,
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
