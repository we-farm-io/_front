// import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/content_model.dart';
import 'package:smart_farm/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      backgroundColor: Colors.lightGreen,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
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
                          padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                height: 350,
                                contents[i].image,
                              ),
                              const SizedBox(
                                height: 0,
                              ),
                              Text(
                                contents[i].title,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 19,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                contents[i].description,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
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
                        dotWidth: 6,
                        expansionFactor: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('onboardingCompleted', true);
                    if (context.mounted) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavNotifier()));
                    }
                  },
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () async {
                    if (currentIndex != contents.length - 1) {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('onboardingCompleted', true);
                      if (context.mounted) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavNotifier()));
                      }
                    }
                  },
                  child:
                      const Text('Next', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
