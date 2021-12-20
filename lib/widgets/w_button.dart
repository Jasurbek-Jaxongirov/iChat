import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color color;
  final Color textColor;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GestureTapCallback onTap;
  final Widget? child;
  final BoxBorder? border;
  final bool loading;
  final bool disabled;

  const WButton(
      {required this.onTap,
      this.width,
      this.height,
      this.text = '',
      this.color = const Color(0xff356AD1),
      this.textColor = Colors.white,
      this.textStyle,
      this.margin,
      this.padding,
      this.border,
      this.loading = false,
      this.disabled = false,
      Key? key,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!(loading || disabled)) {
            onTap();
          }
        },
        child: Container(
          width: width,
          height: height,
          margin: margin,
          padding: padding ?? const EdgeInsets.all(14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: disabled ? Colors.grey : color,
            borderRadius: BorderRadius.circular(8),
            border: border,
          ),
          child: loading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : child ??
                  Text(
                    text,
                    style: textStyle ??
                        Theme.of(context).textTheme.headline3!.copyWith(
                              color: textColor,
                              fontSize: 16,
                            ),
                  ),
        ),
      );
}
