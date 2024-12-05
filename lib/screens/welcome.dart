import 'package:flutter/material.dart';
import 'package:sm_assignment_1/screens/assignment_1.dart';
import 'package:sm_assignment_1/utils/theme/app_colors.dart';
import 'package:sm_assignment_1/utils/theme/app_sizes.dart';
import 'package:sm_assignment_1/utils/theme/app_texts.dart';
import 'package:sm_assignment_1/widgets/custom_button.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.largePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello,\nSM Technology",
              style: AppTexts.heading,
            ),
            const SizedBox(
              height: AppSizes.mediumPadding,
            ),
            const Text(
              "Thank you for checking out my project. All 3 of my assignments are given inside one app. Hope this will not be a problem. Press the next button below to proceed.",
              style: AppTexts.bodyTextLarge,
            ),
            const SizedBox(
              height: AppSizes.largePadding,
            ),
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: "btn",
                child: CustomButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const Assignment1(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
