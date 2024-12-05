import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sm_assignment_1/bloc/api_bloc.dart';
import 'package:sm_assignment_1/utils/theme/app_texts.dart';
import 'package:sm_assignment_1/widgets/custom_button.dart';

class Assignment3 extends StatelessWidget {
  const Assignment3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Assignment 3",
            style: AppTexts.title,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ApiBloc, ApiState>(
          builder: (context, state) {
            if (state is ApiInitial) {
              return Center(
                child: CustomButton(
                  onPressed: () {
                    
                    context.read<ApiBloc>().add(FetchWeatherEvent(
                        latitude: 23.82675662255527,
                        longitude: 90.34918958257161));
                  },
                  child: Text(
                    "Fetch",
                  ),
                ),
              );
            } else if (state is ApiLoading) {
              return const Text("Loading");
            } else if (state is ApiError) {
              return Column(
                children: [
                  Text(state.message),
                  CustomButton(
                    onPressed: () {
                      context.read<ApiBloc>().add(FetchWeatherEvent(
                          latitude: 23.82675662255527,
                          longitude: 90.34918958257161));
                    },
                    child: Text(
                      "Fetch",
                    ),
                  ),
                ],
              );
            } else if (state is ApiLoaded) {
              return Center(
                child: Text(state.weatherData.toJson().toString()),
              );
            }

            return Container();
          },
        ));
  }
}
