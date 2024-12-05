import 'package:flutter/material.dart';
import 'package:sm_assignment_1/screens/assignment_1.dart';
import 'package:sm_assignment_1/screens/assignment_2.dart';
import 'package:sm_assignment_1/screens/assignment_3.dart';
import 'package:sm_assignment_1/utils/theme/app_colors.dart';
import 'package:sm_assignment_1/utils/theme/app_sizes.dart';
import 'package:sm_assignment_1/utils/theme/app_texts.dart';
import 'package:sm_assignment_1/widgets/custom_button.dart';
import 'package:sm_assignment_1/widgets/glassmorphism.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.largePadding),
            child: Glassmorphism(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSizes.largePadding,
                  ),
                  const Text(
                    "Hello,",
                    style: AppTexts.heading,
                  ),
                  const Text(
                    "SM Technology",
                    style: AppTexts.title,
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
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const Assignment1(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          "Assignment 1",
                          style: AppTexts.bodyText,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.mediumPadding,
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const Assignment2(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          "Assignment 2",
                          style: AppTexts.bodyText,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.mediumPadding,
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const Assignment3(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          "Assignment 3",
                          style: AppTexts.bodyText,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.mediumPadding,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
