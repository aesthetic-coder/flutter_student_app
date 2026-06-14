import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_productivity_app/config/theme/app_theme.dart';
import 'package:student_productivity_app/views/screens/root_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Get.offAll(() => const RootPage());
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(width: 80, height: 80, decoration: BoxDecoration(color: AppTheme.lightPrimary, borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.school, size: 40, color: Colors.white)),
            const SizedBox(height: 24),
            const Text('Student Productivity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Manage your academic life', style: TextStyle(color: AppTheme.lightHint)),
          ]),
        ),
      ),
    );
  }
}
