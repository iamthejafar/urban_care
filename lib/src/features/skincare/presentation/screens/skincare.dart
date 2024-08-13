import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:skin_care/src/core/theme/colors.dart';
import 'package:skin_care/src/features/auth/presentation/providers/user_provider.dart';
import 'package:skin_care/src/features/skincare/presentation/providers/add_skincare_provider.dart';
import 'package:skin_care/src/utils/user_preferences.dart';

import '../widgets/skincare_widget.dart';
import '../widgets/streak_widget.dart';

@RoutePage()
class SkinCareScreen extends ConsumerWidget {
  const SkinCareScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(indexProvider);
    final textTheme = Theme.of(context).textTheme;
    final controller = ref.watch(pageController);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: textTheme.titleSmall,
        title: Text(
          selectedIndex == 0 ? "Daily Skincare" : "Streaks",
          style: textTheme.titleSmall,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (value) async {
              if(value == 1) await ref.read(userProvider.notifier).fetchUser(uid: UserPreferences.userId);
            },
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: const [
              SkincareWidget(),
              StreakWidget(),
            ],
          ),

          Container(
            height: 70,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: greyColor))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap : (){
                    ref.read(indexProvider.notifier).state = 0;
                    controller.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       Icon(
                         CupertinoIcons.search,
                        color: selectedIndex == 0 ? greenColor :fontColor2,
                      ),
                      const Gap(5),
                      Text(
                        "Routine",
                        style: selectedIndex == 0 ? textTheme.labelMedium!.copyWith(color: greenColor, fontWeight: FontWeight.w700) : textTheme.labelMedium,
                      )
                    ],
                  ),
                ),
                const Gap(20),
                InkWell(
                  onTap: (){
                    ref.read(indexProvider.notifier).state = 1;
                    controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       Icon(
                        selectedIndex == 1 ? CupertinoIcons.person_2_fill : CupertinoIcons.person_2,
                        color:  selectedIndex == 0 ? greenColor : fontColor2,
                      ),
                      const Gap(5),
                      Text(
                        "Streaks",
                        style: selectedIndex != 1 ? textTheme.labelMedium : textTheme.labelMedium!.copyWith(color: greenColor, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}




