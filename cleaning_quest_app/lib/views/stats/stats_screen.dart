import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/common/guild_nav_bar.dart';
import '../../app/theme/app_theme.dart';
import '../../app/routes/app_routes.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  String selectedPeriod = '今週';

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
                      _buildPeriodSelector(),
                      const SizedBox(height: 15),
                      _buildSummarySection(),
                      const SizedBox(height: 15),
                      _buildWeeklyChart(),
                      const SizedBox(height: 15),
                      _buildRoomStats(),
                      const SizedBox(height: 15),
                      _buildTimeAnalysis(),
                      const SizedBox(height: 15),
                      _buildAchievements(),
                      const SizedBox(height: 80), // ナビゲーションバー分の余白
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GuildNavBar(currentIndex: 2),
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
              const Text('📊', style: TextStyle(fontSize: 24)),
              Text(
                '冒険者の記録書',
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
            '～ 君の軌跡を振り返ろう ～',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textLight,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // 期間選択
  Widget _buildPeriodSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(5),
      decoration: AppTheme.guildPanel,
      child: Row(
        children: ['今週', '今月', '今年'].map((period) {
          final isSelected = selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = period;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [AppTheme.guildGold, AppTheme.guildOrange],
                        )
                      : null,
                  color: isSelected ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? AppTheme.textDark : AppTheme.textLight,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // サマリーセクション
  Widget _buildSummarySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildSummaryCard('23', '総クエスト数')),
              const SizedBox(width: 10),
              Expanded(child: _buildSummaryCard('18h', '総掃除時間')),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.completedGreen, AppTheme.completedGreenDark],
              ),
              border: Border.all(color: const Color(0xFF4CAF50), width: 3),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 1.0 + (0.2 * (1 - (value - 0.5).abs() * 2)),
                      child: child,
                    );
                  },
                  child: const Text('🔥', style: TextStyle(fontSize: 30)),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5日',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: const Color(0xFFE65100),
                            fontSize: 24,
                          ),
                    ),
                    Text(
                      '連続記録',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.paperYellowLight, Color(0xFFFFE082)],
        ),
        border: Border.all(color: AppTheme.guildGold, width: 3),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: const Color(0xFFE65100),
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // 週間活動グラフ
  Widget _buildWeeklyChart() {
    final data = [
      {'day': '月', 'value': 0.8, 'count': 3},
      {'day': '火', 'value': 0.6, 'count': 2},
      {'day': '水', 'value': 0.4, 'count': 1},
      {'day': '木', 'value': 0.9, 'count': 4},
      {'day': '金', 'value': 0.7, 'count': 3},
      {'day': '土', 'value': 1.0, 'count': 5},
      {'day': '日', 'value': 0.85, 'count': 4},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('📈', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                '週間活動グラフ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.map((item) {
                return _buildBarItem(
                  item['day'] as String,
                  item['value'] as double,
                  item['count'] as int,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarItem(String day, double value, int count) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: value,
                  child: Container(
                    width: 20,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.guildGold, AppTheme.guildOrange],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.guildGold.withOpacity(0.3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              day,
              style: const TextStyle(
                color: AppTheme.textLight,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 部屋別統計
  Widget _buildRoomStats() {
    final rooms = [
      {
        'icon': '🔥',
        'name': '台所の洞窟',
        'frequency': '週3回 • 平均35分',
        'progress': 0.85,
        'color': const Color(0xFFFF9800),
      },
      {
        'icon': '🛏️',
        'name': '安らぎの聖域',
        'frequency': '週2回 • 平均20分',
        'progress': 0.6,
        'color': const Color(0xFF4CAF50),
      },
      {
        'icon': '🚿',
        'name': '清めの泉',
        'frequency': '週4回 • 平均15分',
        'progress': 0.95,
        'color': const Color(0xFF2196F3),
      },
      {
        'icon': '🏠',
        'name': '憩いの広場',
        'frequency': '週1回 • 平均45分',
        'progress': 0.3,
        'color': const Color(0xFF9E9E9E),
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🏠', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                'エリア別征服状況',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...rooms.map((room) => _buildRoomStatItem(room)),
        ],
      ),
    );
  }

  Widget _buildRoomStatItem(Map<String, dynamic> room) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.paperYellow, AppTheme.paperYellowLight],
        ),
        border: Border.all(color: AppTheme.guildBeige, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(room['icon'], style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room['name'],
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  room['frequency'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 60,
            child: Column(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: room['progress'],
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            room['color'],
                            (room['color'] as Color).withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 時間分析
  Widget _buildTimeAnalysis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('⏰', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                '時間分析',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _buildTimeCard('28分', '平均掃除時間')),
              const SizedBox(width: 10),
              Expanded(child: _buildTimeCard('朝9時', '最も活発な時間')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildTimeCard('土曜日', '最も活発な曜日')),
              const SizedBox(width: 10),
              Expanded(child: _buildTimeCard('85%', '計画達成率')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        ),
        border: Border.all(color: const Color(0xFF2196F3), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF0D47A1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1565C0),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 達成記録
  Widget _buildAchievements() {
    final achievements = [
      {'icon': '🔥', 'name': '5日連続達成', 'description': '継続は力なり！素晴らしい習慣です'},
      {'icon': '⭐', 'name': 'レベル12到達', 'description': '清掃騎士としての実力を証明'},
      {'icon': '🏠', 'name': '全エリア制覇', 'description': '一日で全ての部屋を掃除完了'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🏆', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                '最近の達成記録',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...achievements.map((achievement) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                ),
                border: Border.all(color: const Color(0xFFFF9800), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.guildGold, AppTheme.guildOrange],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFF8F00),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        achievement['icon']!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement['name']!,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: const Color(0xFFE65100),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          achievement['description']!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: const Color(0xFFF57C00),
                                fontSize: 11,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
