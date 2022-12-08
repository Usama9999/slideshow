import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> slides = [
    '1.jpg',
    '2.jpg',
    '3.jpg',
    '4.jpg',
    '5.jpg',
  ];

  int currentPage = 0;
  late Timer timer;
  PageController pageController = PageController();

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 2), (t) {
      pageController.animateToPage(currentPage + 1,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

      if (currentPage == (slides.length - 1)) {
        currentPage = 0;
        pageController.animateToPage(currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
      currentPage = currentPage + 1;
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: PageView.builder(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              return Image.asset(
                'assets/slides/${slides[index]}',
                fit: BoxFit.cover,
              );
            })),
      ),
    );
  }
}
