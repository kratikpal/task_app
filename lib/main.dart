import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/constants/color_constants.dart';
import 'package:tasks/providers/task_provider.dart';
import 'package:tasks/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TaskProvider())],
      child: MaterialApp(
        title: 'Tasks',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.tdRed),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
