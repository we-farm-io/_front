import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_farm/content_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) => {
                    setState(
                      () {
                        currentIndex = index;
                      },
                    )
                  },
                  controller: _controller,
                  itemCount: contents.length,
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Column(
                        children: [
                          Image(
                            height: 450,
                            image: AssetImage(
                              contents[i].image,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            contents[i].title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            contents[i].description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
              right: 15,
              top: 30,
              child: TextButton(
                onPressed: () => {},
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                child: const Text(
                  'skip',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )),
          Positioned(
            bottom: kBottomNavigationBarHeight + 19,
            left: 25,
            child: SmoothPageIndicator(
              onDotClicked: (index) {
                _controller.animateToPage(index,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeIn);
              },
              controller: _controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.lightGreen,
                dotHeight: 6,
              ),
            ),
          ),
          Positioned(
              right: 15,
              bottom: kBottomNavigationBarHeight,
              child: ElevatedButton(
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size.fromRadius(27)),
                    elevation: MaterialStateProperty.all(1),
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreen)),
                onPressed: () {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeIn);
                },
                child: const Icon(
                  Iconsax.arrow_right_3,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
