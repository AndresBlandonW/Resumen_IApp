import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resume_iapp/screens/home.dart';
import 'package:resume_iapp/services/gptService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create:  (context) => GptService()),
      ],
      child: MaterialApp(
        title: 'Resume IAPP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeApp()
      ),
    );
  }
}