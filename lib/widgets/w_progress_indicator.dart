import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nabh_messenger/app/colors.dart';

class WProgressIndicator extends StatelessWidget {
  const WProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitPouringHourGlassRefined(
      color: AppColors.secondary,
    );
  }
}
