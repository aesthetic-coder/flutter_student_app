import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_productivity_app/controllers/semester_controller.dart';

class SemesterScreen extends StatelessWidget {
  const SemesterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SemesterController>();
    DateTime? startDate, endDate;
    final nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Semesters'), elevation: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(Dialog(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Create Semester', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Semester Name', hintText: 'e.g., Fall 2024')),
                const SizedBox(height: 24),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty && startDate != null && endDate != null) {
                        controller.createSemester(nameController.text, startDate!, endDate!);
                        Get.back();
                      }
                    },
                    child: const Text('Create'),
                  ),
                ]),
              ]),
            ),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        final active = controller.semesters.where((s) => !s.isArchived).toList();
        return active.isEmpty
            ? const Center(child: Text('No semesters yet'))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: active.length,
                itemBuilder: (context, index) {
                  final s = active[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(s.name, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 4), Text('${DateFormat('MMM d').format(s.startDate)} - ${DateFormat('MMM d').format(s.endDate)}', style: Theme.of(context).textTheme.bodySmall)])),
                          if (s.isActive) Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: const Text('Active', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green))),
                        ]),
                        const SizedBox(height: 12),
                        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                          if (!s.isActive) TextButton(onPressed: () => controller.setActiveSemester(s.id), child: const Text('Activate')),
                          TextButton(onPressed: () => controller.archiveSemester(s.id), child: const Text('Archive')),
                          TextButton(onPressed: () => controller.deleteSemester(s.id), child: const Text('Delete')),
                        ]),
                      ]),
                    ),
                  );
                },
              );
      }),
    );
  }
}
