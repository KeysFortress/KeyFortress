import 'package:domain/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/qr_scanner/qr_scanner_viewmodel.dart';
import 'package:stacked/stacked.dart';

class QrScannerView extends StatelessWidget {
  final Function callback;
  final Function? cancelCallback;
  const QrScannerView({super.key, required this.callback, this.cancelCallback});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrScannerViewmodel>.reactive(
      builder: (context, model, child) => Material(
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              model.buildQrView(context),
              Container(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                color: ThemeStyles.theme.primary300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/images/arrow-back.svg",
                        package: "domain",
                      ),
                      onPressed: (() {
                        if (cancelCallback == null) {
                          model.router.backToPrevious(context);
                        }
                        cancelCallback?.call();
                      }),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            "assets/images/flash.svg",
                            package: "domain",
                          ),
                          onPressed: (() => model.toggleFlash()),
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            "assets/images/flip-camera.svg",
                            package: "domain",
                          ),
                          onPressed: (() => model.toggleCamera()),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => QrScannerViewmodel(context, callback),
      onViewModelReady: (viewModel) => viewModel.initialisedModel(context),
    );
  }
}
