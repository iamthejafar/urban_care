import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:skin_care/src/features/auth/presentation/providers/user_provider.dart';
import 'package:skin_care/src/features/skincare/presentation/providers/get_skincare_provider.dart';
import 'package:skin_care/src/features/skincare/presentation/providers/get_streaks_provider.dart';
import 'package:skin_care/src/utils/user_preferences.dart';

import '../../../../comman/widgets/custom_line_chart.dart';
import '../../../../core/theme/colors.dart';


class StreakWidget extends ConsumerWidget {
  const StreakWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final streaksProvider = ref.watch(getStreaksProvider);
    final streaksNotifier = ref.watch(getStreaksProvider.notifier);


    final getUser = ref.read(userProvider);
    return streaksProvider == GetStreaksState.loading ? const Center(child: CircularProgressIndicator()) : streaksProvider == GetStreaksState.error ? Center(child: Text("Something went wrong",style: textTheme.titleMedium,),) : Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Goal: ${UserPreferences.longestStreak + 1} streak days",
              style: textTheme.titleMedium,
            ),
            const Gap(16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Streak Days",
                        style: textTheme.bodyMedium,
                      ),
                      const Gap(14),
                      Text(
                        streaksNotifier.streaks.length.toString(),
                        style: textTheme.titleLarge,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Longest Streak",
                        style: textTheme.bodyMedium,
                      ),
                      const Gap(14),
                      Text(
                        UserPreferences.longestStreak.toString(),
                        style: textTheme.titleLarge,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Gap(30),
            Text(
              "Daily Streak",
              style: textTheme.bodyMedium,
            ),
            const Gap(10),
            Text(
              UserPreferences.currentStreak.toString(),
              style: textTheme.displayLarge,
            ),
            const Gap(5),
            Row(
              children: [
                Text(
                  "Last ${ref.watch(selectedPeriodProvider)} ",
                  style: textTheme.bodyMedium,
                ),
                Text(
                  "+ 100%",
                  style: textTheme.bodyMedium!.copyWith(
                      color: greenColor, fontWeight: FontWeight.w600),
                )
              ],
            ),

            Center(child: AspectRatio(aspectRatio: 1.2,child: CustomLineChart(streaks: streaksNotifier.streaks,),)),
            const Gap(10),
            Text("Keep it up! You're on a roll.",style: textTheme.bodyMedium,),
            const Gap(10),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: greyColor,
              ),
              child: Text("Get Started",style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w700),),
            )
          ]
      ),
    );
  }
}
