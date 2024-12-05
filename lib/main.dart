import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sm_assignment_1/bloc/post_bloc.dart';
import 'package:sm_assignment_1/screens/welcome.dart';
import 'package:sm_assignment_1/utils/theme/app_colors.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("postBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(create: (context) => PostBloc()),
      ],
      child: MaterialApp(
        title: 'SM Technologies',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          scaffoldBackgroundColor: AppColors.backgroundColor,
        ),
        home: const Welcome(),
      ),
    );
  }
}
