// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/features/authentication/screens/sign_up.dart';
import 'package:smart_farm/features/onboarding/models/content_model.dart';
import 'package:smart_farm/shared/widgets/app_navbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<Onboarding> with TickerProviderStateMixin {
  late AnimationController _animationslideController;
  late AnimationController _animationfadeController;

  late PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _animationfadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _animationslideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationfadeController.dispose();
    _animationslideController.dispose();

    super.dispose();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF98C13F),
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
                            if (currentIndex == contents.length - 1) {
                              _animationslideController.forward();
                              _animationfadeController.reverse();
                            } else {
                              _animationslideController.reverse();
                              _animationfadeController.forward();
                            }
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
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOutCubic);
                      },
                      controller: _controller,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Color(0xFF98C13F),
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
          Stack(
            children: [
              GetStarted(
                currentIndex: currentIndex,
                animationController: _animationslideController,
              ),
              NextSkip(
                  animationfadeController: _animationfadeController,
                  currentIndex: currentIndex,
                  controller: _controller),
            ],
          ),
        ],
      ),
    );
  }
}

class NextSkip extends StatefulWidget {
  const NextSkip({
    super.key,
    required AnimationController animationfadeController,
    required this.currentIndex,
    required PageController controller,
  })  : _animationfadeController = animationfadeController,
        _controller = controller;

  final AnimationController _animationfadeController;
  final int currentIndex;
  final PageController _controller;

  @override
  State<NextSkip> createState() => _NextSkipState();
}

class _NextSkipState extends State<NextSkip> {
  @override
  void initState() {
    super.initState();
    widget._animationfadeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget._animationfadeController,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () async {
                if (widget.currentIndex != contents.length - 1) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('onboardingCompleted', true);
                  if (context.mounted) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavBar()));
                  }
                }
              },
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
              onPressed: () {
                if (widget.currentIndex != contents.length - 1) {
                  widget._controller.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOutCubic);
                }
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GetStarted extends StatefulWidget {
  final AnimationController animationController;
  const GetStarted({
    super.key,
    required this.animationController,
    required this.currentIndex,
  });
  final int currentIndex;

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.currentIndex == contents.length - 1) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('onboardingCompleted', true);
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpPage(),
              ),
            );
          }
        }
      },
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(widget.animationController),
        child: FadeTransition(
          opacity: widget.animationController,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              height: 50,
              width: double.infinity,
              child: const Center(
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    color: Color(0xFF98C13F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
