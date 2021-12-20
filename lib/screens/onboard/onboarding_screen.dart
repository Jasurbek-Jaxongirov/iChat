import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nabh_messenger/app/colors.dart';
import 'package:nabh_messenger/data/singletons/storage.dart';
import 'package:nabh_messenger/screens/auth/auth_screen.dart';
import 'package:nabh_messenger/screens/onboard/widgets/onboarding_page_1.dart';
import 'package:nabh_messenger/screens/onboard/widgets/onboarding_page_2.dart';
import 'package:nabh_messenger/screens/onboard/widgets/onboarding_page_3.dart';
import 'package:nabh_messenger/widgets/fade_route.dart';
import 'package:nabh_messenger/widgets/language_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: AppColors.appBar,
            ),
            padding: EdgeInsets.only(top: mediaQuery.padding.top),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 72,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    // color: Colors.white,
                    onPressed: () {
                      showModalBottomSheet<void>(
                        isScrollControlled: false,
                        backgroundColor: Colors.transparent,
                        context: context,
                        useRootNavigator: true,
                        builder: (_) {
                          return const LanguageBottomSheet();
                        },
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.language,
                          color: AppColors.secondary,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'O`zbek tili',
                          style: TextStyle(
                            color: AppColors.secondary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: AppColors.secondary,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: AppColors.secondary,
                    onPressed: () {
                      StorageRepository.putBool('wizard', true);
                      Navigator.of(
                        context,
                        rootNavigator: false,
                      ).pushReplacement(
                        fadeRoute(
                          screen: const AuthScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'O`tkazib yuborish',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(mediaQuery.padding.top + 72),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (i) {
                  setState(() {
                    currentPage = i;
                  });
                },
                children: const [
                  OnboardingPage1(),
                  OnboardingPage2(),
                  OnboardingPage3(),
                ],
                controller: _pageController,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              width: double.maxFinite,
              height: 150,
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (currentPage != 0) {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.linear,
                            );
                          }
                        },
                        child: currentPage == 0
                            ? const SizedBox(width: 30, height: 30)
                            : Container(
                                alignment: Alignment.topCenter,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_outlined,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          expansionFactor: 3,
                          activeDotColor: Colors.grey.shade300,
                          dotColor: Colors.grey.shade300,
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 8,
                        ),
                        onDotClicked: (dotIndex) {
                          _pageController.animateToPage(
                            dotIndex,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.linear,
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (currentPage != 2) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.linear,
                            );
                          } else if (currentPage == 2) {
                            await StorageRepository.putBool('wizard', true);
                            Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushReplacement(
                              fadeRoute(
                                screen: const AuthScreen(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
