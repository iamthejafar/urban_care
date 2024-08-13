import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:skin_care/src/comman/providers/global_providers.dart';
import 'package:skin_care/src/features/skincare/presentation/providers/get_skincare_provider.dart';
import 'package:skin_care/src/features/skincare/presentation/providers/add_skincare_provider.dart';

import '../../../../comman/widgets/app_buttons.dart';
import '../../../../comman/widgets/custom_image_grid.dart';
import '../../../../core/theme/colors.dart';
import '../../../../utils/constants.dart';

class SkincareWidget extends ConsumerWidget {
  const SkincareWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getSkinCareStreakNotifier = ref.watch(getStreakProvider.notifier);
    final getSkinCareStreakProvider = ref.watch(getStreakProvider);
    final textTheme = Theme.of(context).textTheme;
    final addStreakNotifier = ref.watch(addSkincareStreakProvider.notifier);
    final addStreakProvider = ref.watch(addSkincareStreakProvider);
    return getSkinCareStreakProvider == GetStreakState.loading ? const Center(child: CircularProgressIndicator(),) : getSkinCareStreakProvider == GetStreakState.error ? Center(child: Text("Something went wrong.",style: textTheme.titleMedium,),) : Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: skincareProducts.entries.map((entry) {
            String timeString = getSkinCareStreakNotifier.getTimeString(entry.key, getSkinCareStreakNotifier.streak);
            return InkWell(
              onTap: () async {
                await showModalBottomSheet(
                    backgroundColor: backGroundColor,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Text(
                              entry.key,
                              style: textTheme.titleSmall,
                            ),
                            Text(
                              "Add Photos",
                              style: textTheme.bodySmall,
                            ),
                            const Gap(10),
                            CustomImageGrid(providerId: entry.key),
                            const Gap(20),
                            AppButton(
                              text: "Submit",
                              onTap: () async {
                                await addStreakNotifier.addSkincareStreak(
                                    context: context,
                                    title: entry.key,
                                    images: ref
                                        .read(pickedImageProvider(entry.key)));

                                await getSkinCareStreakNotifier.getStreak(date: DateTime.now());
                              },
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: timeString.isNotEmpty ?  const Icon(Icons.check,color: greenColor,) : const Icon(Icons.close,color: Colors.red,),
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: textTheme.bodyMedium,
                            ),
                            SizedBox(
                              width: 220,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                entry.value,
                                style: textTheme.bodySmall,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 27,
                          width: 27,
                          child: Image.asset("assets/images/camera.png"),
                        ),
                        const Gap(10),
                        Text(
                          "08:00 PM",
                          style: textTheme.bodySmall,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ));
  }
}
