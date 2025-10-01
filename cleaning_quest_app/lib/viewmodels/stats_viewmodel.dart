import 'package:flutter/foundation.dart';

class StatsViewModel extends ChangeNotifier {
  // 状態
  bool _isLoading = false;
  String _selectedPeriod = '今週';
  int _totalQuests = 23;
  int _totalHours = 18;
  int _consecutiveDays = 5;

  // ゲッター
  bool get isLoading => _isLoading;
  String get selectedPeriod => _selectedPeriod;
  int get totalQuests => _totalQuests;
  int get totalHours => _totalHours;
  int get consecutiveDays => _consecutiveDays;

  // 期間変更
  void changePeriod(String period) {
    _selectedPeriod = period;

    // 期間に応じてデータを変更
    switch (period) {
      case '今週':
        _totalQuests = 23;
        _totalHours = 18;
        _consecutiveDays = 5;
        break;
      case '今月':
        _totalQuests = 89;
        _totalHours = 67;
        _consecutiveDays = 12;
        break;
      case '今年':
        _totalQuests = 456;
        _totalHours = 298;
        _consecutiveDays = 28;
        break;
    }

    notifyListeners();
  }

  // 初期化
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    // TODO: データの読み込み処理

    _isLoading = false;
    notifyListeners();
  }

  // データ更新
  Future<void> refresh() async {
    await initialize();
  }
}
