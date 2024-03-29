import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/app/constants/app.colors.dart';
import '/presentation/widgets/custom.text.style.dart';

Widget customLoader(
    {required BuildContext context,
    required bool themeFlag,
    required String lottieAsset,
    required String text}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Lottie.asset(
          lottieAsset,
        ),
      ),
      Text(
        text,
        style: CustomTextWidget.bodyTextUltra(
          color: themeFlag ? AppColors.creamColor : AppColors.mirage,
        ),
      ),
    ],
  );
}
