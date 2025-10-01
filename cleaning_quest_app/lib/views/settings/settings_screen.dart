import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/common/guild_nav_bar.dart';
import '../../app/theme/app_theme.dart';
import '../../app/routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool dailyReminder = true;
  bool urgentQuests = true;
  bool achievements = false;
  bool sounds = true;
  bool haptic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.guildBrownDark, AppTheme.guildBrown],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ヘッダー
              _buildHeader(context),

              // コンテンツ
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      _buildProfileSection(),
                      const SizedBox(height: 15),
                      _buildNotificationSettings(),
                      const SizedBox(height: 15),
                      _buildAppSettings(),
                      const SizedBox(height: 15),
                      _buildDataManagement(),
                      const SizedBox(height: 15),
                      _buildSupport(),
                      const SizedBox(height: 15),
                      _buildDangerZone(),
                      const SizedBox(height: 15),
                      _buildVersionInfo(),
                      const SizedBox(height: 80), // ナビゲーションバー分の余白
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GuildNavBar(currentIndex: 3),
    );
  }

  // ヘッダー
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8B4513).withOpacity(0.9),
            const Color(0xFFA0522D).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: const Border(
          bottom: BorderSide(color: AppTheme.guildBeige, width: 4),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('⚙️', style: TextStyle(fontSize: 24)),
              Text(
                'ギルド管理室',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  shadows: AppTheme.goldTextShadow,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.home, color: AppTheme.guildGold),
                onPressed: () => context.go(AppRoutes.home),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            '～ 冒険者の設定と管理 ～',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textLight,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // プロフィールセクション
  Widget _buildProfileSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('👤', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                '冒険者プロフィール',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.paperYellow, AppTheme.paperYellowLight],
              ),
              border: Border.all(color: AppTheme.guildBeige, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.guildGold, AppTheme.guildOrange],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.guildBeige, width: 3),
                  ),
                  child: const Center(
                    child: Text('🤖', style: TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '清掃騎士 ユーザー',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'レベル 12 • 連続冒険 5日目',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showEditProfileDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                  ),
                  child: const Text('編集', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 通知設定
  Widget _buildNotificationSettings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🔔', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                '通知とリマインダー',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildSettingsItem(
            icon: '⏰',
            title: 'デイリーリマインダー',
            description: '毎日決まった時間に掃除を促す',
            value: dailyReminder,
            onChanged: (value) {
              setState(() {
                dailyReminder = value;
              });
            },
          ),
          const SizedBox(height: 8),
          _buildNavigationItem(
            icon: '🕘',
            title: '通知時間',
            description: 'リマインダーを送る時間',
            trailing: '朝9:00',
            onTap: () {
              // 時間選択画面へ
            },
          ),
          const SizedBox(height: 8),
          _buildSettingsItem(
            icon: '🚨',
            title: '緊急クエスト通知',
            description: '長期間掃除していない部屋を通知',
            value: urgentQuests,
            onChanged: (value) {
              setState(() {
                urgentQuests = value;
              });
            },
          ),
          const SizedBox(height: 8),
          _buildSettingsItem(
            icon: '🏆',
            title: '達成通知',
            description: 'レベルアップや記録達成時に通知',
            value: achievements,
            onChanged: (value) {
              setState(() {
                achievements = value;
              });
            },
          ),
        ],
      ),
    );
  }

  // アプリ設定
  Widget _buildAppSettings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('📱', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                'アプリ設定',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildNavigationItem(
            icon: '🎨',
            title: 'テーマ',
            description: 'アプリの外観を選択',
            trailing: 'ギルド',
            onTap: () {
              // テーマ選択画面へ
            },
          ),
          const SizedBox(height: 8),
          _buildNavigationItem(
            icon: '🌐',
            title: '言語',
            description: '表示言語を変更',
            trailing: '日本語',
            onTap: () {
              // 言語選択画面へ
            },
          ),
          const SizedBox(height: 8),
          _buildSettingsItem(
            icon: '🔊',
            title: '効果音',
            description: 'クエスト完了時の音効',
            value: sounds,
            onChanged: (value) {
              setState(() {
                sounds = value;
              });
            },
          ),
          const SizedBox(height: 8),
          _buildSettingsItem(
            icon: '📳',
            title: 'バイブレーション',
            description: 'タップ時のフィードバック',
            value: haptic,
            onChanged: (value) {
              setState(() {
                haptic = value;
              });
            },
          ),
        ],
      ),
    );
  }

  // データ管理
  Widget _buildDataManagement() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('💾', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                'データ管理',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildNavigationItem(
            icon: '📤',
            title: 'データエクスポート',
            description: '掃除履歴をCSVで出力',
            onTap: () {
              // エクスポート処理
              _showInfoDialog('データエクスポート', 'データをエクスポートします');
            },
          ),
          const SizedBox(height: 8),
          _buildNavigationItem(
            icon: '☁️',
            title: 'クラウド同期',
            description: '他デバイスとデータを同期',
            onTap: () {
              // 同期処理
              _showInfoDialog('クラウド同期', 'データを同期します');
            },
          ),
        ],
      ),
    );
  }

  // サポート
  Widget _buildSupport() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('❓', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                'ヘルプとサポート',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildNavigationItem(
            icon: '📖',
            title: '使い方ガイド',
            description: 'アプリの基本的な使い方',
            onTap: () {
              // ガイド画面へ
            },
          ),
          const SizedBox(height: 8),
          _buildNavigationItem(
            icon: '📧',
            title: 'お問い合わせ',
            description: '不具合報告や要望など',
            onTap: () {
              // お問い合わせ画面へ
            },
          ),
          const SizedBox(height: 8),
          _buildNavigationItem(
            icon: '🔒',
            title: 'プライバシーポリシー',
            description: 'データの取り扱いについて',
            onTap: () {
              // プライバシーポリシー画面へ
            },
          ),
        ],
      ),
    );
  }

  // デンジャーゾーン
  Widget _buildDangerZone() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF44336).withOpacity(0.2),
            const Color(0xFFFF5722).withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFF44336), width: 3),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('⚠️', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                'データリセット',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFFFCDD2),
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildDangerItem(
            icon: '🔄',
            title: '進捗をリセット',
            description: 'レベルと統計を初期化',
            onTap: () {
              _showResetDialog(
                '進捗リセット確認',
                'すべての進捗（レベル、EXP、統計）がリセットされます。この操作は取り消せません。',
                () {
                  // リセット処理
                },
              );
            },
          ),
          const SizedBox(height: 8),
          _buildDangerItem(
            icon: '🗑️',
            title: '全データ削除',
            description: 'すべてのデータを削除',
            onTap: () {
              _showResetDialog(
                'データ削除確認',
                'すべてのデータが完全に削除されます。この操作は取り消せません。本当に削除しますか？',
                () {
                  // 削除処理
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // バージョン情報
  Widget _buildVersionInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            '掃除の冒険者ギルド',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textLight,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'バージョン 1.0.0',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppTheme.guildGold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 設定アイテム（トグルスイッチ付き）
  Widget _buildSettingsItem({
    required String icon,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.paperYellow, AppTheme.paperYellowLight],
          ),
          border: Border.all(color: AppTheme.guildBeige, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
            _buildToggleSwitch(value),
          ],
        ),
      ),
    );
  }

  // ナビゲーションアイテム
  Widget _buildNavigationItem({
    required String icon,
    required String title,
    required String description,
    String? trailing,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.paperYellow, AppTheme.paperYellowLight],
          ),
          border: Border.all(color: AppTheme.guildBeige, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
                  ),
                  border: Border.all(color: const Color(0xFF2196F3), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  trailing,
                  style: const TextStyle(
                    color: Color(0xFF0D47A1),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              const Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.guildBeige,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }

  // デンジャーアイテム
  Widget _buildDangerItem({
    required String icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
          ),
          border: Border.all(color: const Color(0xFFF44336), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: const Color(0xFFB71C1C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFFD32F2F),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Text('⚠️', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  // トグルスイッチ
  Widget _buildToggleSwitch(bool value) {
    return Container(
      width: 50,
      height: 28,
      decoration: BoxDecoration(
        gradient: value
            ? const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
              )
            : null,
        color: value ? null : AppTheme.guildBrownLight.withOpacity(0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.guildBeige, width: 2),
      ),
      child: AnimatedAlign(
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // プロフィール編集ダイアログ
  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.paperYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppTheme.guildBeige, width: 3),
        ),
        title: const Text(
          'プロフィール編集',
          style: TextStyle(
            color: AppTheme.textDark,
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'プロフィール編集機能は実装予定です',
          style: TextStyle(color: AppTheme.textMedium),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // 情報ダイアログ
  void _showInfoDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.paperYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppTheme.guildBeige, width: 3),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppTheme.textDark,
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(color: AppTheme.textMedium),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // リセット確認ダイアログ
  void _showResetDialog(String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.paperYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppTheme.guildBeige, width: 3),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppTheme.textDark,
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(color: AppTheme.textMedium),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
              _showInfoDialog('完了', '操作が完了しました');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF44336),
            ),
            child: const Text('実行'),
          ),
        ],
      ),
    );
  }
}
