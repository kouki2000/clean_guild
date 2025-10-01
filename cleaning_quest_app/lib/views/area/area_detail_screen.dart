import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_theme.dart';
import '../../app/routes/app_routes.dart';

class AreaDetailScreen extends StatelessWidget {
  final String roomId;

  const AreaDetailScreen({super.key, required this.roomId});

  // ダミーデータ
  Map<String, dynamic> get roomData {
    final rooms = {
      'kitchen': {
        'icon': '🔥',
        'name': '台所の洞窟',
        'subtitle': '強力な油汚れのボスが潜む危険地帯',
        'difficulty': 'HARD',
        'isUrgent': true,
        'estimatedTime': 35,
        'exp': 80,
        'totalQuests': 5,
        'completedQuests': 1,
        'lastCleaned': '3日前',
        'quests': [
          {
            'icon': '🍽️',
            'name': '食器の山を制圧せよ',
            'description': 'シンクに積まれた食器の要塞を攻略。油汚れのボスが隠れている可能性が高い。',
            'difficulty': 'HARD',
            'time': 15,
            'exp': 30,
            'isUrgent': true,
          },
          {
            'icon': '🔥',
            'name': 'コンロの炎を鎮火せよ',
            'description': 'コンロ周辺の油はねと焦げ付きを除去。特殊な洗剤が効果的。',
            'difficulty': 'NORMAL',
            'time': 10,
            'exp': 20,
            'isUrgent': false,
          },
          {
            'icon': '✨',
            'name': 'シンクを神殿に変える',
            'description': 'シンクを磨き上げて清らかな神殿のように輝かせる。',
            'difficulty': 'EASY',
            'time': 8,
            'exp': 15,
            'isUrgent': false,
          },
          {
            'icon': '🧽',
            'name': 'カウンターの結界を張る',
            'description': '作業台を清拭して新たな料理のための結界を完成させる。',
            'difficulty': 'EASY',
            'time': 7,
            'exp': 15,
            'isCompleted': true,
          },
          {
            'icon': '🏠',
            'name': '床の守護霊を呼び戻す',
            'description': '床を拭き清めて、台所に平和をもたらす守護霊を呼び戻す。',
            'difficulty': 'NORMAL',
            'time': 12,
            'exp': 15,
            'isUrgent': false,
          },
        ],
        'equipment': [
          {'icon': '🧽', 'name': '魔法のスポンジ'},
          {'icon': '🧴', 'name': '油切り薬'},
          {'icon': '🧻', 'name': '清拭の布'},
          {'icon': '🧤', 'name': '守護の手袋'},
        ],
      },
      // 他の部屋も同様に定義可能
    };

    return rooms[roomId] ?? rooms['kitchen']!;
  }

  @override
  Widget build(BuildContext context) {
    final room = roomData;

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
              _buildHeader(context, room),

              // コンテンツ
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      _buildAreaInfo(context, room),
                      const SizedBox(height: 15),
                      _buildQuestSection(context, room),
                      const SizedBox(height: 15),
                      _buildEquipmentSection(context, room),
                      const SizedBox(height: 15),
                      _buildActionButtons(context, room),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ヘッダー
  Widget _buildHeader(BuildContext context, Map<String, dynamic> room) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFF4500).withOpacity(0.9),
            const Color(0xFFFF8C00).withOpacity(0.8),
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
              Text(room['icon'], style: const TextStyle(fontSize: 32)),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      room['name'],
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: Colors.white,
                            shadows: [
                              const Shadow(
                                color: Colors.black54,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      room['subtitle'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFFFECB3),
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (room['isUrgent'])
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF44336).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFF44336),
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    '緊急度: HIGH',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Text(
                  '難易度: ${room['difficulty']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // エリア情報
  Widget _buildAreaInfo(BuildContext context, Map<String, dynamic> room) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(context, '${room['estimatedTime']}分', '推定時間'),
              _buildInfoItem(context, '${room['exp']}', '獲得EXP'),
              _buildInfoItem(
                context,
                '${room['completedQuests']}/${room['totalQuests']}',
                'クエスト',
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.paperYellow, AppTheme.paperYellowLight],
              ),
              border: Border.all(color: AppTheme.guildBeige, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const Text(
                  '最後の征服から',
                  style: TextStyle(color: AppTheme.textMedium, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Text(
                  room['lastCleaned'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color(0xFFE65100),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // クエストセクション
  Widget _buildQuestSection(BuildContext context, Map<String, dynamic> room) {
    final quests = room['quests'] as List<Map<String, dynamic>>;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('⚔️', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                '征服クエスト一覧',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...quests.map(
            (quest) => _buildQuestCard(context, quest, room['name']),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestCard(
    BuildContext context,
    Map<String, dynamic> quest,
    String roomName,
  ) {
    final isCompleted = quest['isCompleted'] ?? false;
    final isUrgent = quest['isUrgent'] ?? false;

    List<Color> gradientColors;
    Color borderColor;

    if (isCompleted) {
      gradientColors = [AppTheme.completedGreen, AppTheme.completedGreenDark];
      borderColor = const Color(0xFF4CAF50);
    } else if (isUrgent) {
      gradientColors = [AppTheme.urgentRed, AppTheme.urgentRedDark];
      borderColor = const Color(0xFFF44336);
    } else {
      gradientColors = [AppTheme.paperYellow, AppTheme.paperYellowLight];
      borderColor = AppTheme.guildBeige;
    }

    return GestureDetector(
      onTap: isCompleted
          ? null
          : () => _showQuestDetailDialog(context, quest, roomName),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (isUrgent)
              BoxShadow(
                color: const Color(0xFFF44336).withOpacity(0.3),
                blurRadius: 15,
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(quest['icon'], style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          quest['name'],
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontFamily: 'Georgia'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.guildBeige, AppTheme.guildBrownLight],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.textMedium, width: 1),
                  ),
                  child: Text(
                    quest['difficulty'],
                    style: const TextStyle(
                      color: AppTheme.guildGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              quest['description'],
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isCompleted)
                  Text(
                    '推定時間: ${quest['time']}分',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textMedium,
                      fontSize: 11,
                    ),
                  )
                else
                  Text(
                    '完了済み',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF4CAF50),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (!isCompleted)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: AppTheme.goldBadge,
                    child: Text(
                      '${quest['exp']} EXP',
                      style: const TextStyle(
                        color: AppTheme.textDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // クエスト詳細ダイアログ
  void _showQuestDetailDialog(
    BuildContext context,
    Map<String, dynamic> quest,
    String roomName,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.paperYellow, AppTheme.paperYellowLight],
          ),
          border: Border(top: BorderSide(color: AppTheme.guildBeige, width: 4)),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(quest['icon'], style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    quest['name'],
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(fontFamily: 'Georgia'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              quest['description'],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppTheme.guildBrownLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '攻略手順',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('• 準備を整える', style: TextStyle(fontSize: 12)),
                  const Text('• 必要な道具を用意', style: TextStyle(fontSize: 12)),
                  const Text('• 順番に作業を進める', style: TextStyle(fontSize: 12)),
                  const Text('• 最後に確認する', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  AppRoutes.goToQuestExecution(
                    context,
                    roomId: roomId,
                    roomName: roomName,
                  );
                },
                child: const Text('このクエストを開始'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 推奨装備セクション
  Widget _buildEquipmentSection(
    BuildContext context,
    Map<String, dynamic> room,
  ) {
    final equipment = room['equipment'] as List<Map<String, dynamic>>;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🛡️', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                '推奨装備',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: equipment.map((item) {
              return Container(
                width: 70,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
                  ),
                  border: Border.all(color: const Color(0xFF2196F3), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(item['icon'], style: const TextStyle(fontSize: 24)),
                    const SizedBox(height: 5),
                    Text(
                      item['name'],
                      style: const TextStyle(
                        color: Color(0xFF0D47A1),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // アクションボタン
  Widget _buildActionButtons(BuildContext context, Map<String, dynamic> room) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: () {
                AppRoutes.goToQuestExecution(
                  context,
                  roomId: roomId,
                  roomName: room['name'],
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('全クエスト開始'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // クエスト編集画面へ
              },
              icon: const Icon(Icons.edit),
              label: const Text('編集'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
