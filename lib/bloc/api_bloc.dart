import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:sm_assignment_1/models/open_weather_model.dart';
import 'package:sm_assignment_1/utils/constants/app_constants.dart';
import 'package:sm_assignment_1/utils/secrets/app_secrets.dart';

abstract class ApiEvent {}

class FetchWeatherEvent extends ApiEvent {
  FetchWeatherEvent();
}

abstract class ApiState {}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiLoaded extends ApiState {
  final OpenWeatherModel weatherData;

  ApiLoaded(this.weatherData);
}

class ApiError extends ApiState {
  final String message;

  ApiError(this.message);
}

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final String apiKey = AppSecrets.openWeatherApiKey;
  final String baseUrl = AppConstants.baseUrlOpenWeather;

  ApiBloc() : super(ApiInitial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(ApiLoading());
      try {
        Position? position = await getCurrentLocation();
        if (position == null) {
          throw Exception("Error fetching user location.");
        }
        final url = Uri.parse(
          '$baseUrl?lat=${position.latitude}&lon=${position.longitude}&exclude=minutely,hourly&appid=$apiKey&units=metric',
        );

        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final weather = OpenWeatherModel.fromJson(data);
          emit(ApiLoaded(weather));
        } else {
          emit(ApiError('Failed to load weather data.'));
        }
      } catch (error) {
        emit(ApiError(error.toString()));
      }
    });
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
