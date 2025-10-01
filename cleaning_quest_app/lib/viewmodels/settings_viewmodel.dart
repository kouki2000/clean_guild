import 'package:flutter/foundation.dart';

class SettingsViewModel extends ChangeNotifier {
  // 状態
  bool _isLoading = false;
  bool _dailyReminder = true;
  bool _urgentQuests = true;
  bool _achievements = false;
  bool _sounds = true;
  bool _haptic = false;

  // ゲッター
  bool get isLoading => _isLoading;
  bool get dailyReminder => _dailyReminder;
  bool get urgentQuests => _urgentQuests;
  bool get achievements => _achievements;
  bool get sounds => _sounds;
  bool get haptic => _haptic;

  // 設定変更
  void toggleDailyReminder(bool value) {
    _dailyReminder = value;
    _saveSettings();
    notifyListeners();
  }

  void toggleUrgentQuests(bool value) {
    _urgentQuests = value;
    _saveSettings();
    notifyListeners();
  }

  void toggleAchievements(bool value) {
    _achievements = value;
    _saveSettings();
    notifyListeners();
  }

  void toggleSounds(bool value) {
    _sounds = value;
    _saveSettings();
    notifyListeners();
  }

  void toggleHaptic(bool value) {
    _haptic = value;
    _saveSettings();
    notifyListeners();
  }

  // 設定保存
  Future<void> _saveSettings() async {
    // TODO: SharedPreferencesに保存
  }

  // 設定読み込み
  Future<void> loadSettings() async {
    _isLoading = true;
    notifyListeners();

    // TODO: SharedPreferencesから読み込み

    _isLoading = false;
    notifyListeners();
  }

  // 初期化
  Future<void> initialize() async {
    await loadSettings();
  }
}
