import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';

import '../../../app/constants/app.assets.dart';
import '../../../app/constants/app.colors.dart';
import '../../../app/routes/app.routes.dart';
import '../../../core/models/onBoarding.model.dart';
import 'widget/onBoarding.widget.dart';


class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final List<OnBoardingModel> cards = [
    OnBoardingModel(
      image: AppAssets.onBoardingOne,
      title: "Happily Serving Under Customer's Feet",
      textColor: Colors.white,
      bgColor: AppColors.mirage,
    ),
    OnBoardingModel(
      image: AppAssets.onBoardingTwo,
      title: "World Class Customer Support On Your Fingertips",
      bgColor: AppColors.creamColor,
      textColor: AppColors.mirage,
    ),
    OnBoardingModel(
      image: AppAssets.onBoardingThree,
      title: "Pay Us With Card For Heavy Discount's",
      bgColor: AppColors.rawSienna,
      textColor: Colors.white,
    ),
  ];

  List<Color> get colors => cards.map((p) => p.bgColor).toList();

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: widget.colors,
        radius: 30,
        itemCount: 3,
        curve: Curves.ease,
        duration: const Duration(seconds: 2),
        itemBuilder: (index) {
          OnBoardingModel card = widget.cards[index % widget.cards.length];
          return PageCard(card: card);
        },
        onFinish: () {
          Navigator.of(context).pushReplacementNamed(AppRouter.splashRoute);
        },
      ),
    );
  }
}
