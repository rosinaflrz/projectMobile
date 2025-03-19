import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_screen.dart';
import 'info_screen.dart';
import 'pomodoro_screen.dart';
import 'main_screen.dart';
import 'login_screen.dart';

// ------------------ Provider para manejar configuración y el temporizador ------------------
class SettingsProvider with ChangeNotifier {
  Color _clockColor = Colors.grey;
  Color _clockTextColor = Colors.white;
  double _clockSize = 200;
  double _fontSize = 40;
  bool _isDarkMode = false;

  // Variables del temporizador
  int _minutes = 25;
  int _seconds = 0;
  Timer? _timer;
  bool _isRunning = false;
  bool _isBreakTime = false;
  String _displayText = "Ready?";

  // Getters
  Color get clockColor => _clockColor;
  Color get clockTextColor => _clockTextColor;
  double get clockSize => _clockSize;
  double get fontSize => _fontSize;
  bool get isDarkMode => _isDarkMode;

  int get minutes => _minutes;
  int get seconds => _seconds;
  bool get isRunning => _isRunning;
  String get displayText => _displayText;

  // Métodos de configuración
  void updateClockColor(Color newColor) {
    _clockColor = newColor;
    notifyListeners();
  }

  void updateClockTextColor(Color newColor) {
    _clockTextColor = newColor;
    notifyListeners();
  }

  void updateClockSize(double newSize) {
    _clockSize = newSize;
    _fontSize = newSize / 5;
    notifyListeners();
  }

  void toggleDarkMode(bool isEnabled) {
    _isDarkMode = isEnabled;
    notifyListeners();
  }

  // Métodos del temporizador
  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _displayText = _isBreakTime ? "Break time!" : "Work time!";
      notifyListeners();

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_seconds == 0) {
          if (_minutes == 0) {
            _timer?.cancel();
            _isRunning = false;

            if (!_isBreakTime) {
              startBreak();
            } else {
              _isBreakTime = false;
              _displayText = "Ready?";
              _minutes = 25;
              _seconds = 0;
            }
            notifyListeners();
          } else {
            _minutes--;
            _seconds = 59;
          }
        } else {
          _seconds--;
        }
        notifyListeners();
      });
    }
  }

  void startBreak() {
    _isBreakTime = true;
    _minutes = 4;
    _seconds = 0;
    _displayText = "Break time!";
    startTimer();
    notifyListeners();
  }

  void pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
      _displayText = _isBreakTime ? "Break time!" : "Ready?";
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// ------------------ Main ------------------
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const PomodoroApp(),
    ),
  );
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro Timer',
      theme: settings.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: const LoginScreen(), // ✅ LoginScreen es la pantalla inicial
    );
  }
}
