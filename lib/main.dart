import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:student_productivity_app/config/theme/app_theme.dart';
import 'package:student_productivity_app/controllers/theme_controller.dart';
import 'package:student_productivity_app/controllers/semester_controller.dart';
import 'package:student_productivity_app/controllers/subject_controller.dart';
import 'package:student_productivity_app/controllers/assignment_controller.dart';
import 'package:student_productivity_app/controllers/exam_controller.dart';
import 'package:student_productivity_app/controllers/attendance_controller.dart';
import 'package:student_productivity_app/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    Get.put(SemesterController());
    Get.put(SubjectController());
    Get.put(AssignmentController());
    Get.put(ExamController());
    Get.put(AttendanceController());

    final themeController = Get.find<ThemeController>();

    return Obx(
      () => MaterialApp(
        title: 'Student Productivity',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
