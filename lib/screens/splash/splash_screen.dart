import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nabh_messenger/app/colors.dart';
import 'package:nabh_messenger/app/icons.dart';
import 'package:nabh_messenger/data/singletons/storage.dart';
import 'package:nabh_messenger/screens/auth/auth_screen.dart';
import 'package:nabh_messenger/screens/onboard/onboarding_screen.dart';
import 'package:nabh_messenger/widgets/fade_route.dart';
import 'package:nabh_messenger/widgets/w_progress_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static Route route() => MaterialPageRoute<void>(
        builder: (_) => const SplashScreen(),
      );
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if (!StorageRepository.getBool('wizard', defValue: false)) {
      Timer(
        const Duration(seconds: 5),
        () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const OnboardingScreen(),
              ),
              (route) => false);
        },
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Container(
          padding: const EdgeInsets.all(30),
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      height: 300,
                      child: SvgPicture.asset(
                        AppIcons.naqsh,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              const WProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
