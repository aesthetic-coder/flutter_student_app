import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_productivity_app/config/theme/app_theme.dart';
import 'package:student_productivity_app/controllers/semester_controller.dart';
import 'package:student_productivity_app/controllers/assignment_controller.dart';
import 'package:student_productivity_app/controllers/exam_controller.dart';
import 'package:student_productivity_app/models/assignment_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final semesterController = Get.find<SemesterController>();
    final assignmentController = Get.find<AssignmentController>();
    final examController = Get.find<ExamController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), elevation: 0, actions: [IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {})]),
      body: Obx(() {
        final semester = semesterController.getActiveSemester();
        if (semester == null) {
          return Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.school_outlined, size: 64, color: AppTheme.lightHint),
              const SizedBox(height: 24),
              const Text('No Semester Yet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Create a semester to get started', style: TextStyle(color: AppTheme.lightHint)),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: () {}, child: const Text('Create Semester')),
            ]),
          );
        }

        final upcomingAssignments = assignmentController.getUpcomingAssignments(7).take(3).toList();
        final upcomingExams = examController.getUpcomingExams(14).take(3).toList();
        final overdueAssignments = assignmentController.getOverdueAssignments();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Welcome back!', style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 8),
            Text('Semester: ${semester.name}', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            if (overdueAssignments.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppTheme.lightError.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  const Icon(Icons.warning_rounded, color: AppTheme.lightError),
                  const SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Overdue Items', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.lightError)),
                    Text('${overdueAssignments.length} item(s) overdue', style: const TextStyle(fontSize: 12, color: AppTheme.lightError)),
                  ]),
                ]),
              ),
            const SizedBox(height: 16),
            if (upcomingAssignments.isNotEmpty) ...
              [Text('Upcoming Assignments', style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 12), ...upcomingAssignments.map((a) => _buildCard(context, a.title, DateFormat('MMM d').format(a.dueDate)))],
            const SizedBox(height: 24),
            if (upcomingExams.isNotEmpty) ...
              [Text('Upcoming Exams', style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 12), ...upcomingExams.map((e) => _buildCard(context, e.title, DateFormat('MMM d').format(e.examDate)))],
          ]),
        );
      }),
    );
  }

  Widget _buildCard(BuildContext context, String title, String date) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 8), Text('Due: $date', style: Theme.of(context).textTheme.bodySmall)])),
    );
  }
}
