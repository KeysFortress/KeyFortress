import 'package:domain/styles.dart';
import 'package:flutter/material.dart';

class SignedInCard extends StatelessWidget {
  const SignedInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ThemeStyles.theme.primary300,
        boxShadow: [
          BoxShadow(
            blurRadius: 150,
            blurStyle: BlurStyle.inner,
            offset: Offset(0, 2),
            spreadRadius: 1,
          )
        ],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(6),
          bottomStart: Radius.circular(6),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeStyles.theme.accent200,
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://lh3.googleusercontent.com/ogw/AKPQZvxclVddeg0hzG30hW337PUKmmB7CWkM0D58hjiE=s32-c-mo",
              ),
              radius: 25,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.theme.text300,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "Kristifor Milchev",
            style: ThemeStyles.regularParagraphOv(
              color: ThemeStyles.theme.text300,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
