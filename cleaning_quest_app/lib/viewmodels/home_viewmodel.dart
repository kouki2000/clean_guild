import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  // 状態
  bool _isLoading = false;
  String _userName = '清掃騎士 ユーザー';
  int _userLevel = 12;
  int _currentExp = 845;
  int _nextLevelExp = 1000;
  int _consecutiveDays = 5;

  // ゲッター
  bool get isLoading => _isLoading;
  String get userName => _userName;
  int get userLevel => _userLevel;
  int get currentExp => _currentExp;
  int get nextLevelExp => _nextLevelExp;
  int get consecutiveDays => _consecutiveDays;
  double get expProgress => _currentExp / _nextLevelExp;

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
