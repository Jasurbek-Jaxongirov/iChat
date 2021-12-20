import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  // color: Color(0XFF6A5DF7),
                  fontWeight: FontWeight.w700,
                ),
                text: 'Ho`sh?! Nimani kutmoqdasiz? ',
                children: [
                  TextSpan(
                    text: '',
                    children: [],
                  ),
                ],
              ),
              // textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                    // fontSize: 18,
                    // color: Color(0XFF6A5DF7),
                    // fontWeight: FontWeight.w700,
                    ),
                text:
                    'Hoziroq iChat ilovasi orqali ro`yxatdan o`ting va safimizga qo`shiling! ',
                children: [
                  TextSpan(
                    text: 'NABH Community ',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showDialog<void>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('NABH Community haqida'),
                            content: const Text(
                                'Lorem ipsum dolor sit amet! Lorem ipsum dolor sit amet! Lorem ipsum dolor sit amet! Lorem ipsum dolor sit amet!'),
                            actions: [
                              MaterialButton(
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.pop(_);
                                },
                                child: const Text(
                                  'Yopish',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    children: const [
                      TextSpan(
                        text:
                            'qo`lidan kelganicha sizga ijtimoiy tarmoqlardagi kerakli qulayliklarni yaratib beradi!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        children: [],
                      ),
                    ],
                  ),
                ],
              ),
              // textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              height: 300,
              child: SvgPicture.asset(
                'assets/icons/done_checking.svg',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
