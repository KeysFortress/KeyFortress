import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/cloud_connection_status/cloud_connection_status_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CloudConnectionStatus extends StatelessWidget {
  const CloudConnectionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CloudConnectionStatusViewModel(context),
      builder: (context, viewModel, child) => Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: ThemeStyles.theme.background300,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/images/cloud-not-connected.svg",
              package: "domain",
              width: 24,
              height: 24,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                ThemeStyles.theme.primary300,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Offline",
              style: ThemeStyles.regularParagraphOv(
                color: ThemeStyles.theme.primary300,
                size: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
