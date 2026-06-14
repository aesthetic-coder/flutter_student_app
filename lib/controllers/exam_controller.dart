import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:student_productivity_app/models/exam_model.dart';

class ExamController extends GetxController {
  final storage = GetStorage();
  final exams = <Exam>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadExams();
  }

  void _loadExams() {
    final data = storage.read('exams');
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      exams.value = jsonList.map((e) => Exam.fromJson(e)).toList();
    }
  }

  void _saveExams() {
    final jsonList = exams.map((e) => e.toJson()).toList();
    storage.write('exams', jsonEncode(jsonList));
  }

  void addExam(Exam exam) {
    exams.add(exam);
    _saveExams();
  }

  List<Exam> getUpcomingExams(int days) {
    final now = DateTime.now();
    final futureDate = now.add(Duration(days: days));
    return exams.where((e) => e.examDate.isAfter(now) && e.examDate.isBefore(futureDate)).toList()..sort((a, b) => a.examDate.compareTo(b.examDate));
  }
}
