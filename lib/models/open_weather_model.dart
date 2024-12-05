// Model Created by https://app.quicktype.io/

import 'dart:convert';

OpenWeatherModel openWeatherModelFromJson(String str) => OpenWeatherModel.fromJson(json.decode(str));

String openWeatherModelToJson(OpenWeatherModel data) => json.encode(data.toJson());

class OpenWeatherModel {
    double lat;
    double lon;
    String timezone;
    int timezoneOffset;
    Current current;
    List<Minutely> minutely;
    List<Current> hourly;
    List<Daily> daily;
    List<Alert> alerts;

    OpenWeatherModel({
        required this.lat,
        required this.lon,
        required this.timezone,
        required this.timezoneOffset,
        required this.current,
        required this.minutely,
        required this.hourly,
        required this.daily,
        required this.alerts,
    });

    factory OpenWeatherModel.fromJson(Map<String, dynamic> json) => OpenWeatherModel(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: Current.fromJson(json["current"]),
        minutely: List<Minutely>.from(json["minutely"].map((x) => Minutely.fromJson(x))),
        hourly: List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
        alerts: List<Alert>.from(json["alerts"].map((x) => Alert.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "current": current.toJson(),
        "minutely": List<dynamic>.from(minutely.map((x) => x.toJson())),
        "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
        "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
        "alerts": List<dynamic>.from(alerts.map((x) => x.toJson())),
    };
}

class Alert {
    String senderName;
    String event;
    int start;
    int end;
    String description;
    List<dynamic> tags;

    Alert({
        required this.senderName,
        required this.event,
        required this.start,
        required this.end,
        required this.description,
        required this.tags,
    });

    factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        senderName: json["sender_name"],
        event: json["event"],
        start: json["start"],
        end: json["end"],
        description: json["description"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "sender_name": senderName,
        "event": event,
        "start": start,
        "end": end,
        "description": description,
        "tags": List<dynamic>.from(tags.map((x) => x)),
    };
}

class Current {
    int dt;
    int? sunrise;
    int? sunset;
    double temp;
    double feelsLike;
    int pressure;
    int humidity;
    double dewPoint;
    double uvi;
    int clouds;
    int visibility;
    double windSpeed;
    int windDeg;
    double windGust;
    List<Weather> weather;
    double? pop;

    Current({
        required this.dt,
        this.sunrise,
        this.sunset,
        required this.temp,
        required this.feelsLike,
        required this.pressure,
        required this.humidity,
        required this.dewPoint,
        required this.uvi,
        required this.clouds,
        required this.visibility,
        required this.windSpeed,
        required this.windDeg,
        required this.windGust,
        required this.weather,
        this.pop,
    });

    factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"]?.toDouble(),
        uvi: json["uvi"]?.toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"]?.toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"]?.toDouble(),
        weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        pop: json["pop"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "pop": pop,
    };
}

class Weather {
    int id;
    String main;
    String description;
    String icon;

    Weather({
        required this.id,
        required this.main,
        required this.description,
        required this.icon,
    });

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
    };
}

class Daily {
    int dt;
    int sunrise;
    int sunset;
    int moonrise;
    int moonset;
    double moonPhase;
    String summary;
    Temp temp;
    FeelsLike feelsLike;
    int pressure;
    int humidity;
    double dewPoint;
    double windSpeed;
    int windDeg;
    double windGust;
    List<Weather> weather;
    int clouds;
    double pop;
    double rain;
    double uvi;

    Daily({
        required this.dt,
        required this.sunrise,
        required this.sunset,
        required this.moonrise,
        required this.moonset,
        required this.moonPhase,
        required this.summary,
        required this.temp,
        required this.feelsLike,
        required this.pressure,
        required this.humidity,
        required this.dewPoint,
        required this.windSpeed,
        required this.windDeg,
        required this.windGust,
        required this.weather,
        required this.clouds,
        required this.pop,
        required this.rain,
        required this.uvi,
    });

    factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"]?.toDouble(),
        summary: json["summary"],
        temp: Temp.fromJson(json["temp"]),
        feelsLike: FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"]?.toDouble(),
        windSpeed: json["wind_speed"]?.toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"]?.toDouble(),
        weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: json["clouds"],
        pop: json["pop"]?.toDouble(),
        rain: json["rain"]?.toDouble(),
        uvi: json["uvi"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "summary": summary,
        "temp": temp.toJson(),
        "feels_like": feelsLike.toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds,
        "pop": pop,
        "rain": rain,
        "uvi": uvi,
    };
}

class FeelsLike {
    double day;
    double night;
    double eve;
    double morn;

    FeelsLike({
        required this.day,
        required this.night,
        required this.eve,
        required this.morn,
    });

    factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
    };
}

class Temp {
    double day;
    double min;
    double max;
    double night;
    double eve;
    double morn;

    Temp({
        required this.day,
        required this.min,
        required this.max,
        required this.night,
        required this.eve,
        required this.morn,
    });

    factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"]?.toDouble(),
        min: json["min"]?.toDouble(),
        max: json["max"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
    };
}

class Minutely {
    int dt;
    int precipitation;

    Minutely({
        required this.dt,
        required this.precipitation,
    });

    factory Minutely.fromJson(Map<String, dynamic> json) => Minutely(
        dt: json["dt"],
        precipitation: json["precipitation"],
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "precipitation": precipitation,
    };
}
