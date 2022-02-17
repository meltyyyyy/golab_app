import 'package:flutter/material.dart';
import 'package:golab/const/color.dart';


class AppButton extends StatelessWidget {
  final double? width;
  final String text;
  final Color primary;
  final Color onPrimary;
  final bool border;
  final VoidCallback? onPressed;

  const AppButton.primary({
    double? width,
    required String text,
    required VoidCallback? onPressed,
  }) : this(
    width: width,
    text: text,
    onPressed: onPressed,
    primary: AppColor.main,
    onPrimary: AppColor.background,
    border: false,
  );

  const AppButton.dialogNeutral({
    required String text,
    required VoidCallback onPressed,
  }) : this(
    text: text,
    onPressed: onPressed,
    width: null,
    primary: AppColor.dialogBackground,
    onPrimary: AppColor.text,
    border: true,
  );

  const AppButton.neutral({
    required String text,
    required VoidCallback onPressed,
  }) : this(
    text: text,
    onPressed: onPressed,
    width: null,
    primary: AppColor.background,
    onPrimary: AppColor.text,
    border: true,
  );

  const AppButton.danger({
    required String text,
    required VoidCallback? onPressed,
  }) : this(
    text: text,
    onPressed: onPressed,
    width: null,
    primary: AppColor.attentionText,
    onPrimary: AppColor.dialogBackground,
    border: false,
  );

  const AppButton({
    this.width,
    required this.text,
    required this.primary,
    required this.onPrimary,
    required this.border,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 40,
      child: ElevatedButton(
        child: Text(text),
        style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14),
            primary: primary,
            onPrimary: onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: (border == true)
                  ? const BorderSide(color: AppColor.border)
                  : const BorderSide(color: Colors.transparent),
            ),
            elevation: 0),
        onPressed: onPressed,
      ),
    );
  }
}