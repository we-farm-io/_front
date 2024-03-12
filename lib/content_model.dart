class OnBoardingContent {
  String image;
  String title;
  String description;
  OnBoardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnBoardingContent> contents = [
  OnBoardingContent(
    image: "assets/images/on_boarding_images/plant_disease.gif",
    title: "PlantDoc",
    description: "eliminate disease , preserve your harvest",
  ),
  OnBoardingContent(
      image: "assets/images/on_boarding_images/plant_care.gif",
      title: "PlantCare",
      description: "make your plants feel better"),
  OnBoardingContent(
    image: "assets/images/on_boarding_images/plant_twerking.gif",
    title: "AgroInsight",
    description:
        "not sure what to seed? Our AI model will make a decision for you",
  )
];
