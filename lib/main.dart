import 'package:quiz_app/screens/add_or_edit_question.dart';
import 'package:quiz_app/screens/questions_list.dart';
import 'package:quiz_app/splash_screen.dart';

import '../Auth/login_screen.dart';
import '../auth/signup_screen.dart';
import '../auth/fogot_password.dart';
import 'screens/home_screen.dart';
import '../screens/admin_login.dart';
import '../screens/leaderboard.dart';
import '../screens/prvious_scores.dart';
import '../screens/quiz_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/phone_auth/login_with_phone_number.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.amber,
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
                    .copyWith(secondary: Colors.indigo)),
        home: const SplashScreen(),
        routes: {
          LoginWithPhoneNumber.routeName: (context) =>
              const LoginWithPhoneNumber(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          ForgotPasswordScreen.routeName: (context) =>
              const ForgotPasswordScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          QuizScreen.routeName: (context) => const QuizScreen(),
          PreviousScores.routeName: (context) => const PreviousScores(),
          LeaderboardSCreen.routeName: (context) => const LeaderboardSCreen(),
          AdminLogin.routeName: (context) => AdminLogin(),
          QuestionsList.routeName:(context) =>  const QuestionsList(),
          AddOrEditQuestionScreen.routeName:(context) => const AddOrEditQuestionScreen(),
        });
  }
}
