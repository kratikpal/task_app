import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/constants/color_constants.dart';
import 'package:tasks/providers/task_provider.dart';
import 'package:tasks/screens/home_screen.dart';
import 'package:tasks/screens/login_screen.dart';
import 'package:tasks/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Tasks',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.tdRed),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: auth.FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) =>
              snapshot.hasData ? const HomeScreen() : LoginScreen(),
        ),
      ),
    );
  }
}
