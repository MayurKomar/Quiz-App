import '../Auth/login_screen.dart';
import '../screens/leaderboard.dart';
import '../screens/prvious_scores.dart';
import '../screens/quiz_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final auth = FirebaseAuth.instance;

  static const routeName = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              auth.signOut().then((value) => Navigator.of(context)
                  .pushReplacementNamed(LoginScreen.routeName));
            },
            icon: const Icon(Icons.logout))
      ]),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(QuizScreen.routeName);
                },
                child: const Text("Start new Quiz"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(PreviousScores.routeName);
                },
                child: const Text("Previous Scores"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LeaderboardSCreen.routeName);
                },
                child: const Text("Leaderboard"),
              ),
            ]),
      ),
    );
  }
}
