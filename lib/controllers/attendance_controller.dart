import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:student_productivity_app/models/attendance_model.dart';

class AttendanceController extends GetxController {
  final storage = GetStorage();
  final attendanceRecords = <AttendanceRecord>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadAttendance();
  }

  void _loadAttendance() {
    final data = storage.read('attendance');
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      attendanceRecords.value = jsonList.map((e) => AttendanceRecord.fromJson(e)).toList();
    }
  }

  void _saveAttendance() {
    final jsonList = attendanceRecords.map((e) => e.toJson()).toList();
    storage.write('attendance', jsonEncode(jsonList));
  }

  void markAttendance(String subjectId, DateTime date, AttendanceStatus status) {
    final existing = attendanceRecords.firstWhereOrNull((a) => a.subjectId == subjectId && isSameDay(a.date, date));
    if (existing != null) attendanceRecords.remove(existing);
    attendanceRecords.add(AttendanceRecord(subjectId: subjectId, date: date, status: status));
    _saveAttendance();
  }

  bool isSameDay(DateTime date1, DateTime date2) => date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;

  double getAttendancePercentage(String subjectId) {
    final records = attendanceRecords.where((a) => a.subjectId == subjectId).toList();
    if (records.isEmpty) return 0;
    final present = records.where((a) => a.status == AttendanceStatus.present || a.status == AttendanceStatus.leave).length;
    return (present / records.length) * 100;
  }
}
