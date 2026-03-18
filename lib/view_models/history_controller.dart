import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/database_helper.dart';

class BmiRecord {
  final int? id;
  final String userId;
  final DateTime date;
  final double bmi;
  final double weight;
  final String status;
  
  BmiRecord({this.id, required this.userId, required this.date, required this.bmi, required this.weight, required this.status});

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'date': date.toIso8601String(),
    'bmi': bmi,
    'weight': weight,
    'status': status,
  };

  factory BmiRecord.fromJson(Map<String, dynamic> json) => BmiRecord(
    id: json['id'],
    userId: json['userId'] ?? '',
    date: DateTime.parse(json['date']),
    bmi: json['bmi'],
    weight: json['weight'] ?? 0.0, // Default for old records
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

  Future<void> saveBmi(double bmi, double weight, String status) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';
    final record = BmiRecord(
      userId: userId,
      date: DateTime.now(),
      bmi: bmi,
      weight: weight,
      status: status,
    );
    await DatabaseHelper.instance.create(record.toJson());
    await loadHistory(); // Refresh list
  }

  Future<void> loadHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';
    final data = await DatabaseHelper.instance.readHistoryForUser(userId);
    history.value = data.map((e) => BmiRecord.fromJson(e)).toList();
  }

  Future<void> clearHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';
    await DatabaseHelper.instance.deleteAllForUser(userId);
    history.clear();
  }
}
