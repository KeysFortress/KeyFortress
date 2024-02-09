import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthentinicationType extends StatelessWidget {
  final String heading;
  final String description;
  final List<String> images;
  final Function onEnablePressed;

  const AuthentinicationType({
    super.key,
    required this.heading,
    required this.description,
    required this.images,
    required this.onEnablePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ThemeStyles.width,
      height: ThemeStyles.height,
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images
                    .map((e) => SvgPicture.asset(
                          e,
                          package: "domain",
                          width: ThemeStyles.width! / 9,
                          height: ThemeStyles.height! / 9,
                        ))
                    .toList()),
          ),
          Container(
            height: 130,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.fromLTRB(16, 4, 16, 0),
            decoration: BoxDecoration(
              color: ThemeStyles.theme.background200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                Text(
                  heading,
                  style: ThemeStyles.regularParagraphOv(
                    color: ThemeStyles.theme.primary300,
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: ThemeStyles.regularParagraphOv(
                    color: ThemeStyles.theme.text100,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: CustomIconButton(
              height: 50,
              buttonColor: ThemeStyles.theme.primary300,
              label: "Enabled",
              callback: () {
                onEnablePressed.call();
              },
            ),
          )
        ],
      ),
    );
  }
}
