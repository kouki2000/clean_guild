import 'package:flutter/foundation.dart';

class MapViewModel extends ChangeNotifier {
  // 状態
  bool _isLoading = false;
  int _completedAreas = 4;
  int _totalAreas = 7;
  int _urgentAreas = 2;

  // ゲッター
  bool get isLoading => _isLoading;
  int get completedAreas => _completedAreas;
  int get totalAreas => _totalAreas;
  int get urgentAreas => _urgentAreas;
  double get overallProgress => _completedAreas / _totalAreas;
  int get progressPercentage => (overallProgress * 100).round();

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
