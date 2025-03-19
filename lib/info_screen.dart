import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("What is Pomodoro?")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What’s Pomodoro?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "The Pomodoro Technique is a time management method that involves working in 25-minute intervals, called pomodoros, with short breaks in between. "
              "The goal is to improve focus and productivity by breaking tasks into manageable chunks.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
