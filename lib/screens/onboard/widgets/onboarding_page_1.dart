import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

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
                  fontWeight: FontWeight.w700,
                ),
                text:
                    'Shariat talablariga moslashtirilgan dastur izlamoqdamisiz? ',
                children: [],
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'iChat - Shariat talablariga moslashtirilgan ilova. Sizga va yaqinlaringizga qo`limizdan kelgancha xizmat qilishga tayyormiz!',
            ),
            const Spacer(),
            SizedBox(
              height: 300,
              child: SvgPicture.asset(
                'assets/icons/empty_cart.svg',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
