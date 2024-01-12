import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/custom_button/custom_button.dart';

class NavMenuInner extends StatelessWidget {
  final Widget? icon;
  final Widget? button;
  final Widget? column;
  final String location;
  final Function callback;
  final bool isLabelHidden;
  final Color fontColor;
  final bool ignoreRestriction;

  const NavMenuInner({
    super.key,
    required this.location,
    required this.callback,
    this.isLabelHidden = false,
    this.icon,
    this.button,
    this.column,
    this.fontColor = Colors.white,
    this.ignoreRestriction = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 40, 0, 6),
      decoration: BoxDecoration(
        color: ThemeStyles.theme.primary300,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Stack(
              children: [
                Positioned(
                  child: SvgPicture.asset(
                    "assets/images/arrow-back.svg",
                    package: "domain",
                    width: 19.16,
                    height: 37.33,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Positioned(
                  left: 0,
                  child: CustomButton(
                    callback: () => callback.call(),
                    widget: Container(
                      padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
                      child: Text(""),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!isLabelHidden)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) icon!,
                Visibility(
                  visible: icon != null,
                  child: const SizedBox(
                    width: 12,
                  ),
                ),
                SizedBox(
                  width: location.length > 20 && ignoreRestriction == false
                      ? 250
                      : null,
                  child: Text(
                    location,
                    style: ThemeStyles.innerHeadingOv(
                      fontSize: 20,
                      letterSpacing: 2,
                      weight: FontWeight.w500,
                      color: fontColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          if (isLabelHidden && column != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 50,
                ),
                column!
              ],
            ),
          if (button != null)
            Positioned(
              right: 12,
              child: button!,
            )
        ],
      ),
    );
  }
}
