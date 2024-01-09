import 'package:domain/styles.dart';
import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final Color? foreground;
  final Color? background;
  final int fill;
  final String? label;
  const CustomProgressBar({
    super.key,
    required this.fill,
    this.background,
    this.foreground,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background ?? ThemeStyles.theme.primary300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: fill,
            child: Container(
              height: 25,
              decoration: BoxDecoration(
                color: foreground,
                borderRadius: BorderRadiusDirectional.circular(
                  10,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    label ?? "",
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.text300,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 100 - fill,
            child: Container(
              height: 25,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10),
                  bottomEnd: Radius.circular(10),
                ),
              ),
              child: const Text(""),
            ),
          ),
        ],
      ),
    );
  }
}
