

import 'package:flutter/material.dart';
import 'package:skin_care/src/core/theme/colors.dart';


class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    required this.text,
    this.textStyle,
    this.isLoading = false
  });
  final void Function()? onTap;
  final String text;
  final TextStyle? textStyle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(fontColor1),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
      ),
      child: isLoading ? const CircularProgressIndicator(color: backGroundColor,) : Text(
        text,
        style: textStyle ?? textTheme.bodySmall!.copyWith(color: backGroundColor),
      ),
    );
  }
}
