import 'package:flutter/material.dart';
import 'package:skin_care/src/core/theme/colors.dart';





void showLoading(BuildContext context, {String? message}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  color: backGroundColor, borderRadius: BorderRadius.circular(12)),
              child: const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            )),
      );
    },
  );
}