import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final String hintText;
  final Color? fillColor;
  final bool hasHeight;
  final bool isFilled;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final Widget? suffix;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool hasBorder;
  final bool autoFocus;
  final TextStyle? style;
  final Color? cursorColor;
  final Function()? onTap;
  final FocusNode? focusNode;
  const WTextField({
    Key? key,
    this.onChanged,
    this.autoFocus = false,
    this.hasHeight = false,
    this.hasBorder = true,
    this.hintStyle,
    this.style,
    this.cursorColor,
    required this.controller,
    this.hintText = '',
    this.fillColor,
    this.isFilled = false,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.isPassword = false,
    this.onTap,
    this.focusNode,
    this.minLines,
    this.maxLines,
  }) : super(key: key);

  @override
  _WTextFieldState createState() => _WTextFieldState();
}

class _WTextFieldState extends State<WTextField> {
  @override
  Widget build(BuildContext context) => SizedBox(
        height: widget.hasHeight ? null : 44,
        child: Stack(
          children: [
            TextField(
              obscureText: widget.isPassword,
              focusNode: widget.focusNode,
              cursorWidth: 2,
              cursorHeight: 20,
              controller: widget.controller,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              keyboardType: widget.keyboardType,
              minLines: widget.minLines,
              maxLines: widget.maxLines ?? 1,
              cursorColor: widget.cursorColor,
              autofocus: widget.autoFocus,
              style: widget.style,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                filled: widget.isFilled,
                suffixIcon: widget.suffix,
                prefix: widget.prefix,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle,
                alignLabelWithHint: true,
                border: InputBorder.none,
                fillColor: widget.fillColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: widget.hasBorder
                      ? const BorderSide(
                          color: Color(0XFFF7C700),
                        )
                      : BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      );
}
