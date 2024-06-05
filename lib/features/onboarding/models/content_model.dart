import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OnBoardingContent {
  final String image;
  final String title;
  final String description;

  OnBoardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingContent> getOnBoardingContents(BuildContext context) {
  return [
    OnBoardingContent(
      image: "assets/images/on_boarding_images/3.svg",
      title: AppLocalizations.of(context)!.getSeedRecommendations,
      description: AppLocalizations.of(context)!.notSureWhatToSeed,
    ),
    OnBoardingContent(
      image: "assets/images/on_boarding_images/1.svg",
      title: AppLocalizations.of(context)!.examineYourPlants,
      description: AppLocalizations.of(context)!.eliminateDisease,
    ),
    OnBoardingContent(
      image: "assets/images/on_boarding_images/2.svg",
      title: AppLocalizations.of(context)!.manageYourFarmEfficiently,
      description: AppLocalizations.of(context)!.makeYourPlantsFeelBetter,
    ),
  ];
}
