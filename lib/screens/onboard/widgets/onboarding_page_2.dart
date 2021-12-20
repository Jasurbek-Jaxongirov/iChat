import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({Key? key}) : super(key: key);

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
                text:
                    'Har qanday noshar`iy kontentlarga qarshi filterlarga ega ilova! ',
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
            const Text(
                'Siz va yaqinlaringizga zarar yetkazishi mumkin bo`lgan shar`iy har qanday ta`qiqlangan kontentlardan mustahkam himoya!'),
            const Spacer(),
            SizedBox(
              height: 300,
              child: SvgPicture.asset(
                'assets/icons/empty_list.svg',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
