import 'package:flutter/material.dart';
import 'package:mon_appli/couverture/composants_navigate.dart';
import 'package:mon_appli/home/landing_page.dart';
import 'package:mon_appli/home/login_page.dart';
  class Navigate extends StatefulWidget {
    const Navigate({super.key});

    @override
    State<Navigate> createState() => _OnboardingScreenState();
  }

  class _OnboardingScreenState extends State<Navigate> {
    late final OnboardingController controller;
    final List<OnboardingPage> pages = [
      OnboardingPage(
     imagePath: "assets/images/Thesis-rafiki.png",
        title: 'votre professeur d\'orientation',
     description: "profite d'une meilleur experience",
    ),
      OnboardingPage(
     imagePath: "assets/images/Learning-rafiki.png",
        title: 'votre professeur d\'orientation',
     description: "pour une meilleur oriente academique et professionnel",
      ),
      OnboardingPage(
        imagePath: "assets/images/graduation hats-rafiki.png",
        title: 'votre professeur d\'orientation',
        description: " pour un avenir meilleur ",
      )
    ];
    @override
    void initState() {
      super.initState();
      controller = OnboardingController();
    }
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: controller.pageController,
                itemCount: pages.length,
                physics: const ClampingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    controller.currentPage = index ;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingContent(page: pages[index]);
               }
              ),
               Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PageIndicator(
                            currentPage: controller.currentPage,
                            pagecount: pages.length,
                          ),
                          const SizedBox(height: 20),
                          OnboardingActionButtom(
                            isLastPage: controller.currentPage == pages.length -1,
                            onPressed: () {
                              if (controller.currentPage == pages.length - 1) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()
                                  ),
                                );
                              } else {
                                controller.nextPage();
                              }
                            },
                          ),
                        ],
                      ),
                  ),
             )
            ],
          ),
        ),
      );
    }
  }
