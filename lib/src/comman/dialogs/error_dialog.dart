import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skin_care/src/comman/widgets/app_buttons.dart';
import 'package:skin_care/src/core/theme/colors.dart';


void showErrorDialog(BuildContext context, {required String message}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      final textTheme = Theme.of(context).textTheme;
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: backGroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(20),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall,
                  ),
                  const Gap(20),
                  AppButton(
                    onTap: () {
                      context.router.maybePop();
                      context.router.maybePop();
                    },
                    text: "Ok",
                  ),
                  const Gap(20),
                ],
              ),
            )),
      );
    },
  );
}
