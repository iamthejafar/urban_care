
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_care/src/features/skincare/presentation/providers/get_streaks_provider.dart';
import 'package:skin_care/src/utils/user_preferences.dart';

import '../../core/theme/colors.dart';
import '../../features/skincare/domain/entity/streak.dart';


class CustomLineChart extends ConsumerWidget {
  const CustomLineChart({
    super.key, required this.streaks,
  });

  final List<Streak> streaks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStreaks = getStreaksByPeriod(streaks, ref.read(selectedPeriodProvider));
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        LineChart(LineChartData(
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (value) => greyColor,
            )
          ),
          borderData: FlBorderData(
              show: false
          ),
          gridData: const FlGridData(
              show: false
          ),
          titlesData: const FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          minX: 0,
          maxX: double.parse(UserPreferences.longestStreak.toString()),
          minY: 0,
          maxY: double.parse(selectedStreaks.length.toString()),
          lineBarsData: [
            LineChartBarData(
              spots:  [
                for(int i=0; i<selectedStreaks.length; i++)
                  FlSpot(double.parse(i.toString()), double.parse(selectedStreaks[i].streak.toString()))
              ],
              gradient: LinearGradient(colors: [
                greenColor,
                greenColor.withOpacity(1
                )
              ]),
              isCurved: true,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        greenColor.withOpacity(0.3),
                        greenColor.withOpacity(0.2),
                        greenColor.withOpacity(0.1),
                        greenColor.withOpacity(0.1),
                        greyColor.withOpacity(0)
                      ])
              ),
            ),
          ],
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment as needed
          children: periods.map((period) {
            return InkWell(
              onTap: () {
                ref.read(selectedPeriodProvider.notifier).state = period;
              },
              borderRadius: BorderRadius.circular(30),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Text(
                  period,
                  style: ref.watch(selectedPeriodProvider) == period
                      ? textTheme.bodyMedium!.copyWith(color: greenColor)
                      : textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400, color: fontColor2),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

List<Streak> filterStreaks(List<Streak> streaks, DateTime startDate, DateTime endDate) {
  return streaks.where((streak) {
    return streak.date.isAfter(startDate) && streak.date.isBefore(endDate);
  }).toList();
}
final periods = ["1W", "2W", "1M", "3M", "1Y"];

List<Streak> getStreaksByPeriod(List<Streak> streaks, String period) {
  final now = DateTime.now();

  DateTime startDate;

  switch (period) {
    case '1W':
      startDate = now.subtract(const Duration(days: 7));
      break;
    case '2W':
      startDate = now.subtract(const Duration(days: 14));
      break;
    case '1M':
      startDate = DateTime(now.year, now.month - 1, now.day);
      break;
    case '3M':
      startDate = DateTime(now.year, now.month - 3, now.day);
      break;
    case '1Y':
      startDate = DateTime(now.year - 1, now.month, now.day);
      break;
    default:
      throw ArgumentError('Invalid period: $period');
  }

  return filterStreaks(streaks, startDate, now);
}

