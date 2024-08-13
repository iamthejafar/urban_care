
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skin_care/src/comman/widgets/app_buttons.dart';
import 'package:skin_care/src/core/router/router.gr.dart';




@RoutePage()
class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'No Internet',
              style: textTheme.titleMedium,
            ),
          ),
          AppButton(
            onTap: () {
              context.router.replaceAll([const AuthRoute()]);
            },
            text: 'Try Again',
            ),
        ],
      ),
    );
  }
}