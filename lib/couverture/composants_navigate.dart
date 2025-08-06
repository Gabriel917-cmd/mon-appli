import 'package:flutter/material.dart';

  class OnboardingPage  {
    final String description;

    final String imagePath;

    const OnboardingPage({
      required this.description,
      required this.imagePath,
      });
  }
    class OnboardingController {
       final PageController pageController;
       int currentPage;

       OnboardingController()
         : pageController = PageController(),
           currentPage = 0;
        void nextPage() {
          if (currentPage > 2) {
            pageController.nextPage(
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
            );
            currentPage++;
    }
    }
    void dispose() {
          pageController.dispose();
    }
    }
    class PageIndicator extends StatelessWidget {
       final int currentPage;
       final int pagecount;

       const PageIndicator({
         super.key,
         required this.currentPage,
         required  this.pagecount,
    });

    @override
    Widget build(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pagecount,
            (index) => AnimatedContainer(
                duration: const Duration(seconds: 2),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentPage == index ? 8 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? Colors.blue
                      :Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                )
            )
        )
      );
    }
  }
  class OnboardingContent extends StatelessWidget {
    final OnboardingPage page;

    const OnboardingContent({super.key,
      required this.page
    });

    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox( height: 50),
              Hero (
                tag: "images" ,
                child: Image.asset(
                  page.imagePath,
                  height: 300,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 300,
                    color: Colors.grey[200],
                    child: const Icon(Icons.book, size: 50, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 170),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  page.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
              )

            ],
          ),
          ),
        ],
      );

    }
  }
  class OnboardingActionButtom extends StatelessWidget {
    final bool isLastPage;
    final VoidCallback onPressed;
    const OnboardingActionButtom({
      super.key,
      required this.isLastPage,
      required this.onPressed,
    });

    @override
    Widget build(BuildContext context) {
      return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: isLastPage
          ? ElevatedButton(
             style:  ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10 ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
            shadowColor: Colors.blue.withOpacity(0.5),
          ),
         onPressed: onPressed,
         child: const Text("commencer",
         style: TextStyle(
           fontSize: 18,
           fontWeight: FontWeight.bold,
           color: Colors.white,
         ),
         ),
      )
              :  ElevatedButton(
              style:  ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10 ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 4,
                shadowColor: Colors.blue.withOpacity(0.5),
              ),
            onPressed: onPressed,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
            children: [ Text("next",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox( width: 8),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 20,
            )
              ]
          )
          )
      );
    }
  }
