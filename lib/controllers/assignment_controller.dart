import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:student_productivity_app/models/assignment_model.dart';

class AssignmentController extends GetxController {
  final storage = GetStorage();
  final assignments = <Assignment>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadAssignments();
  }

  void _loadAssignments() {
    final data = storage.read('assignments');
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      assignments.value = jsonList.map((e) => Assignment.fromJson(e)).toList();
    }
  }

  void _saveAssignments() {
    final jsonList = assignments.map((e) => e.toJson()).toList();
    storage.write('assignments', jsonEncode(jsonList));
  }

  void addAssignment(Assignment assignment) {
    assignments.add(assignment);
    _saveAssignments();
  }

  List<Assignment> getUpcomingAssignments(int days) {
    final now = DateTime.now();
    final futureDate = now.add(Duration(days: days));
    return assignments
        .where((a) => a.dueDate.isAfter(now) && a.dueDate.isBefore(futureDate) && a.status != AssignmentStatus.submitted)
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  List<Assignment> getOverdueAssignments() {
    return assignments.where((a) => a.isOverdue && a.status != AssignmentStatus.submitted).toList()..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }
}
