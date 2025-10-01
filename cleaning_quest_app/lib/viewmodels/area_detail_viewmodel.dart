import 'package:flutter/foundation.dart';

class AreaDetailViewModel extends ChangeNotifier {
  // 状態
  bool _isLoading = false;
  String? _currentRoomId;

  // ゲッター
  bool get isLoading => _isLoading;
  String? get currentRoomId => _currentRoomId;

  // 初期化
  void initialize(String roomId) {
    _currentRoomId = roomId;
    notifyListeners();
  }

  // データ更新
  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();

    // TODO: データの読み込み処理

    _isLoading = false;
    notifyListeners();
  }
}
