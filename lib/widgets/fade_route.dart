import 'package:flutter/material.dart';

Route fadeRoute({
  required Widget screen,
  int value = 200,
}) =>
    PageRouteBuilder<dynamic>(
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) {
        return screen;
      },
      transitionDuration: Duration(milliseconds: value),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeOut;
        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
