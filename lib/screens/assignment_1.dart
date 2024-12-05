import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_assignment_1/bloc/post_bloc.dart';
import 'package:sm_assignment_1/utils/theme/app_colors.dart';
import 'package:sm_assignment_1/utils/theme/app_sizes.dart';
import 'package:sm_assignment_1/utils/theme/app_texts.dart';
import 'package:sm_assignment_1/widgets/custom_button.dart';
import 'package:sm_assignment_1/widgets/glassmorphism.dart';

class Assignment1 extends StatelessWidget {
  const Assignment1({super.key});

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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.mediumPadding),
              child: Glassmorphism(
                child: Column(
                  children: [
                    const Text(
                      "Assignment 1",
                      style: AppTexts.title,
                    ),
                    const Text(
                      "Fetching Data From API",
                      style: AppTexts.tinyText,
                    ),
                    BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                      if (state is PostInitial) {
                        return Padding(
                          padding: const EdgeInsets.only(top: AppSizes.mediumPadding),
                          child: CustomButton(
                            onPressed: () {
                              context.read<PostBloc>().add(FetchPosts());
                            },
                            child: Text(
                              "Fetch Data",
                              textAlign: TextAlign.center,
                              style: AppTexts.bodyText.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        );
                      } else if (state is PostLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.whiteColor,
                          ),
                        );
                      } else if (state is PostError) {
                        return Center(
                          child: Text(
                            state.error,
                            style: AppTexts.errorText,
                          ),
                        );
                      } else if (state is PostLoaded) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.posts.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  // left: AppSizes.mediumPadding,
                                  // right: AppSizes.mediumPadding,
                                  top: AppSizes.mediumPadding,
                                ),
                                child: Glassmorphism(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.posts[index].title.toUpperCase(),
                                        style: AppTexts.bodyText,
                                      ),
                                      const Divider(),
                                      Text(
                                        state.posts[index].body,
                                        style: AppTexts.tinyText,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }

                      return const FlutterLogo();
                    }),
                    const SizedBox(
                      height: AppSizes.mediumPadding,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: AppSizes.mediumPadding + AppSizes.mediumPadding,
            right: AppSizes.mediumPadding + AppSizes.mediumPadding,
            bottom: AppSizes.largePadding + AppSizes.mediumPadding,
            child: CustomButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Row(
                  children: [
                    Text(
                      "Go Back",
                      style: AppTexts.bodyText,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.whiteColor,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
