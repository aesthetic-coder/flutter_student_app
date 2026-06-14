import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:student_productivity_app/models/subject_model.dart';

class SubjectController extends GetxController {
  final storage = GetStorage();
  final subjects = <Subject>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSubjects();
  }

  void _loadSubjects() {
    final data = storage.read('subjects');
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      subjects.value = jsonList.map((e) => Subject.fromJson(e)).toList();
    }
  }

  void _saveSubjects() {
    final jsonList = subjects.map((e) => e.toJson()).toList();
    storage.write('subjects', jsonEncode(jsonList));
  }

  void addSubject(Subject subject) {
    subjects.add(subject);
    _saveSubjects();
  }

  void deleteSubject(String subjectId) {
    subjects.removeWhere((s) => s.id == subjectId);
    _saveSubjects();
  }

  List<Subject> getSubjectsBySemester(String semesterId) {
    return subjects.where((s) => s.semesterId == semesterId).toList();
  }
}
