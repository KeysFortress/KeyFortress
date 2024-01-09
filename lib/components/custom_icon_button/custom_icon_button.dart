import 'package:flutter/material.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/components/custom_icon_button/custom_icon_button_viewmodel.dart';
import 'package:stacked/stacked.dart';

//ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  final Widget? icon;
  final String label;
  final Function callback;
  final Color? buttonColor;

  late Color fontColor;
  bool enabled;
  final bool playAnim;
  final double? btnRadius;
  BoxBorder? border;
  final bool expand;
  final double? height;

  CustomIconButton({
    super.key,
    required this.label,
    this.icon,
    required this.callback,
    this.buttonColor = const Color(0xFF288ba3),
    this.fontColor = const Color.fromRGBO(255, 255, 255, 0.9),
    this.enabled = true,
    this.playAnim = false,
    this.btnRadius,
    this.border,
    this.expand = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CustomIconButtonViewModel(),
      onViewModelReady: (viewModel) => viewModel.ready(playAnim),
      builder: (context, viewModel, child) {
        var button = CustomButton(
          enabled: enabled,
          callback: () => enabled ? callback.call() : {},
          widget: Opacity(
            opacity: enabled ? 1 : 0.5,
            child: Container(
              height: height,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: buttonColor,
                border: border,
                borderRadius: BorderRadius.circular(
                  btnRadius ?? 3,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: icon != null,
                    child: icon ?? const Text(""),
                  ),
                  if (icon != null && label.isNotEmpty)
                    const SizedBox(
                      width: 6,
                    ),
                  if (label.isNotEmpty)
                    Text(
                      label,
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 12,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Loto",
                      ),
                    ),
                  if (icon != null && label.isNotEmpty)
                    const SizedBox(
                      width: 6,
                    ),
                ],
              ),
            ),
          ),
        );

        return expand
            ? Expanded(
                flex: expand ? 1 : 0,
                child: button,
              )
            : button;
      },
    );
  }
}
