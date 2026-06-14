import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_productivity_app/controllers/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Container(width: 100, height: 100, decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor), child: const Icon(Icons.person, size: 50, color: Colors.white)),
              const SizedBox(height: 24),
              Card(child: ListTile(leading: const Icon(Icons.dark_mode_outlined), title: const Text('Dark Mode'), trailing: Switch(value: themeController.isDarkMode.value, onChanged: (value) => themeController.toggleTheme()))),
            ]),
          )),
    );
  }
}
