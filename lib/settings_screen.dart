import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'login_screen.dart'; // ✅ Importamos LoginScreen para cerrar sesión

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showColorPicker(BuildContext context, Color currentColor, Function(Color) onColorChanged) {
    Color selectedColor = currentColor;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick a color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
              showLabel: false,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                onColorChanged(selectedColor);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()), // ✅ Regresa a Login
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Opción para activar/desactivar modo oscuro
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Dark Mode:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Switch(
                  value: settings.isDarkMode,
                  onChanged: (value) {
                    settings.toggleDarkMode(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ✅ Opción para cambiar el color del reloj
            const Text("Clock Color:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () => _showColorPicker(context, settings.clockColor, settings.updateClockColor),
              child: Container(width: 30, height: 30, color: settings.clockColor),
            ),
            const SizedBox(height: 20),

            // ✅ Opción para cambiar el color de los números del reloj
            const Text("Clock Text Color:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () => _showColorPicker(context, settings.clockTextColor, settings.updateClockTextColor),
              child: Container(width: 30, height: 30, color: settings.clockTextColor),
            ),
            const SizedBox(height: 20),

            // ✅ Slider para cambiar el tamaño del reloj y el texto
            const Text("Clock & Text Size:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: settings.clockSize,
              min: 100,
              max: 300,
              divisions: 4,
              label: "${settings.clockSize.toInt()} px",
              onChanged: (newSize) {
                settings.updateClockSize(newSize);
              },
            ),
            const SizedBox(height: 40),

            // ✅ Botón de "Cerrar Sesión"
            Center(
              child: ElevatedButton(
                onPressed: () => _logout(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Logout", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
