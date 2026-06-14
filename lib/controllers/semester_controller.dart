import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:student_productivity_app/models/semester_model.dart';

class SemesterController extends GetxController {
  final storage = GetStorage();
  final semesters = <Semester>[].obs;
  final activeSemesterId = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    _loadSemesters();
  }

  void _loadSemesters() {
    final data = storage.read('semesters');
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      semesters.value = jsonList.map((e) => Semester.fromJson(e)).toList();
      final activeSem = semesters.firstWhereOrNull((s) => s.isActive);
      activeSemesterId.value = activeSem?.id;
    }
  }

  void _saveSemesters() {
    final jsonList = semesters.map((e) => e.toJson()).toList();
    storage.write('semesters', jsonEncode(jsonList));
  }

  void createSemester(String name, DateTime startDate, DateTime endDate) {
    final semester = Semester(
      name: name,
      startDate: startDate,
      endDate: endDate,
      isActive: semesters.isEmpty,
    );
    semesters.add(semester);
    if (semester.isActive) {
      activeSemesterId.value = semester.id;
    }
    _saveSemesters();
  }

  void setActiveSemester(String semesterId) {
    semesters.value = semesters.map((s) => s.copyWith(isActive: s.id == semesterId)).toList();
    activeSemesterId.value = semesterId;
    _saveSemesters();
  }

  void archiveSemester(String semesterId) {
    final index = semesters.indexWhere((s) => s.id == semesterId);
    if (index != -1) {
      semesters[index] = semesters[index].copyWith(isArchived: true);
      if (semesters[index].isActive) {
        final newActive = semesters.firstWhereOrNull((s) => !s.isArchived && s.id != semesterId);
        if (newActive != null) {
          setActiveSemester(newActive.id);
        }
      }
      _saveSemesters();
    }
  }

  void deleteSemester(String semesterId) {
    semesters.removeWhere((s) => s.id == semesterId);
    if (activeSemesterId.value == semesterId) {
      if (semesters.isNotEmpty) {
        activeSemesterId.value = semesters.first.id;
      } else {
        activeSemesterId.value = null;
      }
    }
    _saveSemesters();
  }

  Semester? getActiveSemester() {
    if (activeSemesterId.value == null) return null;
    return semesters.firstWhereOrNull((s) => s.id == activeSemesterId.value);
  }
}
