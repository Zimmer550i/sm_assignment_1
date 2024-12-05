import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_assignment_1/bloc/api_bloc.dart';
import 'package:sm_assignment_1/utils/theme/app_colors.dart';
import 'package:sm_assignment_1/utils/theme/app_sizes.dart';
import 'package:sm_assignment_1/utils/theme/app_texts.dart';
import 'package:sm_assignment_1/widgets/custom_button.dart';
import 'package:sm_assignment_1/widgets/glassmorphism.dart';

class Assignment3 extends StatelessWidget {
  const Assignment3({super.key});

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
                      "Assignment 3",
                      style: AppTexts.title,
                    ),
                    const Text(
                      "Fetching Data From Third-Party API",
                      style: AppTexts.tinyText,
                    ),
                    BlocBuilder<ApiBloc, ApiState>(
                      builder: (context, state) {
                        if (state is ApiInitial) {
                          return CustomButton(
                            onPressed: () {
                              context.read<ApiBloc>().add(FetchWeatherEvent());
                            },
                            child: const Text(
                              "Fetch",
                              style: AppTexts.bodyText,
                            ),
                          );
                        } else if (state is ApiLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                            ),
                          );
                        } else if (state is ApiError) {
                          return Column(
                            children: [
                              Center(
                                child: Text(
                                  state.message,
                                  style: AppTexts.errorText,
                                ),
                              ),
                              CustomButton(
                                onPressed: () {
                                  context
                                      .read<ApiBloc>()
                                      .add(FetchWeatherEvent());
                                },
                                child: const Text(
                                  "Fetch",
                                ),
                              ),
                              const SizedBox(
                                height: AppSizes.largePadding * 5,
                              )
                            ],
                          );
                        } else if (state is ApiLoaded) {
                          return Expanded(
                            child: ListView(
                              children: state.weatherData
                                  .toJson()
                                  .entries
                                  .map((entry) {
                                return _buildRow(entry.key, entry.value);
                              }).toList(),
                            ),
                          );
                        }

                        return Container();
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return ExpansionTile(
        collapsedIconColor: AppColors.whiteColor,
        iconColor: AppColors.whiteColor,
        title: Text(
          key,
          style: AppTexts.bodyText,
        ),
        children: value.entries.map((e) => _buildRow(e.key, e.value)).toList(),
      );
    }

    if (value is List) {
      return ListTile(
        title: Text(
          key,
          style: AppTexts.tinyText,
        ),
        subtitle: Text(
          value.join(', '),
          style: AppTexts.tinyText,
        ),
      );
    }

    return ListTile(
      title: Text(
        key,
        style: AppTexts.tinyText,
      ),
      subtitle: Text(
        value.toString(),
        style: AppTexts.tinyText,
      ),
    );
  }
}
