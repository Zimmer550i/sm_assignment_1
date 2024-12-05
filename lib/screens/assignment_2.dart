import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sm_assignment_1/bloc/post_bloc.dart';
import 'package:sm_assignment_1/utils/theme/app_colors.dart';
import 'package:sm_assignment_1/utils/theme/app_sizes.dart';
import 'package:sm_assignment_1/utils/theme/app_texts.dart';
import 'package:sm_assignment_1/widgets/custom_button.dart';
import 'package:sm_assignment_1/widgets/glassmorphism.dart';

class Assignment2 extends StatefulWidget {
  const Assignment2({super.key});

  @override
  State<Assignment2> createState() => _Assignment2State();
}

class _Assignment2State extends State<Assignment2> {
  bool isLoaded = false;
  final box = Hive.box('postBox');

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
                      "Assignment 2",
                      style: AppTexts.title,
                    ),
                    const Text(
                      "Hive Database Usege",
                      style: AppTexts.bodyText,
                    ),
                    ValueListenableBuilder(
                      valueListenable: box.listenable(),
                      builder: (context, Box<dynamic> box, _) {
                        final postData = box.get('data');
                        final postCount =
                            postData == null ? 0 : (postData as List).length;

                        return Text(
                          "Offline Storage: $postCount Posts",
                          style: AppTexts
                              .tinyText, // Replace with your custom style
                        );
                      },
                    ),
                    BlocBuilder<PostBloc, PostState>(
                      builder: (context, state) {
                        if (!isLoaded) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: AppSizes.mediumPadding,
                              ),
                              CustomButton(
                                onPressed: () {
                                  context.read<PostBloc>().add(FetchPosts());
                                  context.read<PostBloc>().add(SavePosts());
                                },
                                child: state is PostLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: AppColors.whiteColor,
                                      ))
                                    : Text(
                                        "Fetch and Save",
                                        style: AppTexts.bodyText.copyWith(
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                              ),
                              const SizedBox(
                                width: double.maxFinite,
                                height: AppSizes.mediumPadding,
                              ),
                              CustomButton(
                                onPressed: () {
                                  context.read<PostBloc>().add(LoadPosts());
                                  setState(() {
                                    isLoaded = true;
                                  });
                                },
                                child: Text(
                                  "Load",
                                  style: AppTexts.bodyText.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: (state as PostLoaded).posts.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: AppSizes.mediumPadding,
                                  ),
                                  child: Glassmorphism(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.posts[index].title
                                              .toUpperCase(),
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
                      },
                    ),
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
