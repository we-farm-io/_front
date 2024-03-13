class OnBoardingContent {
  String image;
  String title;
  String description;
  OnBoardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnBoardingContent> contents = [
  OnBoardingContent(
    image: "assets/images/on_boarding_images/3.svg",
    title: "Get seed recommendations",
    description:
        "Not sure what to seed? Our AI model will make a decision for you",
  ),
  OnBoardingContent(
    image: "assets/images/on_boarding_images/1.svg",
    title: "Examine your plants",
    description: "eliminate disease , preserve your harvest",
  ),
  OnBoardingContent(
      image: "assets/images/on_boarding_images/2.svg",
      title: "Manage your Farm efficiently",
      description: "make your plants feel better"),
];
