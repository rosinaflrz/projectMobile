import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("POMODORO"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Texto de estado: Ready?, Work time! o Break time!
          Text(settings.displayText, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // Reloj circular con el tiempo
          Container(
            width: settings.clockSize,
            height: settings.clockSize,
            decoration: BoxDecoration(shape: BoxShape.circle, color: settings.clockColor),
            alignment: Alignment.center,
            child: Text(
              "${settings.minutes.toString().padLeft(2, '0')}:${settings.seconds.toString().padLeft(2, '0')}",
              style: TextStyle(fontSize: settings.fontSize, fontWeight: FontWeight.bold, color: settings.clockTextColor),
            ),
          ),
          const SizedBox(height: 20),

          // Botones de Play y Pause
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.pause, size: 40),
                onPressed: settings.isRunning ? settings.pauseTimer : null,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.play_arrow, size: 40),
                onPressed: !settings.isRunning ? settings.startTimer : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
