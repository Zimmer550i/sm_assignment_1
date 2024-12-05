import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_assignment_1/bloc/post_bloc.dart';
import 'package:sm_assignment_1/screens/assignment_2.dart';
import 'package:sm_assignment_1/utils/theme/app_colors.dart';
import 'package:sm_assignment_1/utils/theme/app_sizes.dart';
import 'package:sm_assignment_1/utils/theme/app_texts.dart';
import 'package:sm_assignment_1/widgets/custom_button.dart';

class Assignment1 extends StatelessWidget {
  const Assignment1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Assignment 1",
          style: AppTexts.title,
        ),
        centerTitle: true,
      ),
      floatingActionButton: Hero(
        tag: "btn",
        child: CustomButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const Assignment2(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
        if (state is PostInitial) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  onPressed: () {
                    context.read<PostBloc>().add(FetchPosts());
                  },
                  child: Text(
                    "Fetch Data",
                    style: AppTexts.bodyText.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is PostLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostError) {
          return Center(
            child: Text(
              state.error,
              style: AppTexts.errorText,
            ),
          );
        } else if (state is PostLoaded) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: AppSizes.mediumPadding,
                  right: AppSizes.mediumPadding,
                  top: AppSizes.mediumPadding,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(
                        AppSizes.smallPadding,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 5,
                          spreadRadius: 2,
                          color: AppColors.blackColor.withOpacity(0.2),
                        )
                      ]),
                  padding: const EdgeInsets.all(AppSizes.mediumPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
          );
        }

        return const FlutterLogo();
      }),
    );
  }
}
