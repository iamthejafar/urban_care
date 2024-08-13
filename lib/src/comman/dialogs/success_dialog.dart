import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skin_care/src/comman/widgets/app_buttons.dart';
import 'package:skin_care/src/core/theme/colors.dart';

void successDialog(BuildContext context,
    {String? message, Function()? onPressed}) {
  final textTheme = Theme.of(context).textTheme;
  showDialog(
    useRootNavigator: false,
    context: context,
    builder: (_) => Dialog(
      backgroundColor: backGroundColor,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 270),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Gap(10),
            Container(
              width: 82,
              height: 82,
              decoration: const BoxDecoration(
                color: greenColor,
                shape: BoxShape.circle,
              ),
              child: const Center(
                  child: Icon(
                Icons.check,
                size: 50,
                color: backGroundColor,
              )),
            ),
            const Gap(14),
            Text("Successful", style: textTheme.titleMedium),
            const Gap(14),
            Text(message ?? "Task completed successfully",
                style: textTheme.bodySmall),
            Gap(10),
            AppButton(
              text: "Ok",
              textStyle: textTheme.bodyLarge!.copyWith(color: backGroundColor),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            Gap(10),
          ],
        ),
      ),
    ),
  );
}
