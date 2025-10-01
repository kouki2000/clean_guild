import 'package:flutter/foundation.dart';

class QuestExecutionViewModel extends ChangeNotifier {
  // 状態
  bool _isLoading = false;
  String? _currentRoomId;
  String? _currentRoomName;

  // ゲッター
  bool get isLoading => _isLoading;
  String? get currentRoomId => _currentRoomId;
  String? get currentRoomName => _currentRoomName;

  // 初期化
  void initialize({String? roomId, String? roomName}) {
    _currentRoomId = roomId;
    _currentRoomName = roomName;
    notifyListeners();
  }

  // クエスト開始
  Future<void> startQuest() async {
    // TODO: クエスト開始処理
  }

  // クエスト完了
  Future<void> completeQuest() async {
    // TODO: クエスト完了処理
  }
}
