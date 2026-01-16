import 'package:get/get.dart';
import '../data/database_helper.dart';

class BmiRecord {
  final int? id;
  final DateTime date;
  final double bmi;
  final String status;
  
  BmiRecord({this.id, required this.date, required this.bmi, required this.status});

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'bmi': bmi,
    'status': status,
  };

  factory BmiRecord.fromJson(Map<String, dynamic> json) => BmiRecord(
    id: json['id'],
    date: DateTime.parse(json['date']),
    bmi: json['bmi'],
    status: json['status'],
  );
}

class HistoryController extends GetxController {
  var history = <BmiRecord>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> saveBmi(double bmi, String status) async {
    final record = BmiRecord(
      date: DateTime.now(),
      bmi: bmi,
      status: status,
    );
    await DatabaseHelper.instance.create(record.toJson());
    await loadHistory(); // Refresh list
  }

  Future<void> loadHistory() async {
    final data = await DatabaseHelper.instance.readAllHistory();
    history.value = data.map((e) => BmiRecord.fromJson(e)).toList();
  }

  Future<void> clearHistory() async {
    await DatabaseHelper.instance.deleteAll();
    history.clear();
  }
}
