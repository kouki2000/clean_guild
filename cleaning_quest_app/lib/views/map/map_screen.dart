import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/common/guild_nav_bar.dart';
import '../../app/theme/app_theme.dart';
import '../../app/routes/app_routes.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

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
                      _buildProgressSummary(context),
                      const SizedBox(height: 15),
                      _buildHouseLayout(context),
                      const SizedBox(height: 15),
                      _buildLegend(context),
                      const SizedBox(height: 80), // ナビゲーションバー分の余白
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GuildNavBar(currentIndex: 1),
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
              const Text('🗺️', style: TextStyle(fontSize: 24)),
              Text(
                '冒険者の住まい',
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
            '～ 征服すべき7つのエリア ～',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textLight,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // 進捗サマリー
  Widget _buildProgressSummary(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(15),
      decoration: AppTheme.guildPanel,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem(context, '4/7', '制覇エリア'),
          _buildSummaryItem(context, '57%', '全体進捗'),
          _buildSummaryItem(context, '2', '緊急事態'),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: const Color(0xFFE65100),
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.textMedium,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // 家のレイアウト
  Widget _buildHouseLayout(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 400,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD7CCC8), Color(0xFFBCAAA4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppTheme.guildBeige, width: 4),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20),
        ],
      ),
      child: Stack(
        children: [
          // 台所（左上）
          Positioned(
            top: 20,
            left: 20,
            child: _buildRoomCard(
              context,
              icon: '🔥',
              name: '台所の洞窟',
              status: 'ボス出現中',
              progress: 0.2,
              isUrgent: true,
              roomId: 'kitchen',
            ),
          ),

          // リビング（右上）
          Positioned(
            top: 20,
            right: 20,
            child: _buildRoomCard(
              context,
              icon: '✅',
              name: '憩いの広場',
              status: '制覇済み',
              progress: 1.0,
              isCompleted: true,
              roomId: 'living',
            ),
          ),

          // 寝室（左下）
          Positioned(
            bottom: 100,
            left: 20,
            child: _buildRoomCard(
              context,
              icon: '🛏️',
              name: '安らぎの聖域',
              status: '探索中',
              progress: 0.6,
              isInProgress: true,
              roomId: 'bedroom',
            ),
          ),

          // バスルーム（右下）
          Positioned(
            bottom: 100,
            right: 20,
            child: _buildRoomCard(
              context,
              icon: '🚿',
              name: '清めの泉',
              status: '制覇済み',
              progress: 1.0,
              isCompleted: true,
              roomId: 'bathroom',
            ),
          ),

          // 玄関（中央下）
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: _buildRoomCard(
                context,
                icon: '🚪',
                name: '冒険者の門',
                status: '侵入者あり',
                progress: 0.2,
                isUrgent: true,
                roomId: 'entrance',
                width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 部屋カード
  Widget _buildRoomCard(
    BuildContext context, {
    required String icon,
    required String name,
    required String status,
    required double progress,
    required String roomId,
    bool isUrgent = false,
    bool isCompleted = false,
    bool isInProgress = false,
    double width = 90,
  }) {
    Color borderColor;
    List<Color> gradientColors;

    if (isCompleted) {
      borderColor = const Color(0xFF4CAF50);
      gradientColors = [AppTheme.completedGreen, AppTheme.completedGreenDark];
    } else if (isUrgent) {
      borderColor = const Color(0xFFF44336);
      gradientColors = [AppTheme.urgentRed, AppTheme.urgentRedDark];
    } else if (isInProgress) {
      borderColor = const Color(0xFFFF9800);
      gradientColors = [const Color(0xFFFFF3E0), const Color(0xFFFFE0B2)];
    } else {
      borderColor = AppTheme.guildBeige;
      gradientColors = [AppTheme.paperYellow, AppTheme.paperYellowLight];
    }

    return GestureDetector(
      onTap: () {
        AppRoutes.goToAreaDetail(context, roomId);
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: borderColor, width: 3),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isUrgent
                  ? const Color(0xFFF44336).withOpacity(0.4)
                  : isCompleted
                  ? const Color(0xFF4CAF50).withOpacity(0.4)
                  : Colors.black.withOpacity(0.2),
              blurRadius: isUrgent ? 15 : 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 5),
            Text(
              name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Text(
              status,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 8),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            // 進捗バー
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isCompleted
                          ? [const Color(0xFF4CAF50), const Color(0xFF8BC34A)]
                          : isInProgress
                          ? [const Color(0xFFFF9800), const Color(0xFFFFC107)]
                          : [const Color(0xFFF44336), const Color(0xFFFF5722)],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 凡例
  Widget _buildLegend(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.guildBrownLight.withOpacity(0.9),
        border: Border.all(color: AppTheme.guildBeige, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '凡例',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppTheme.guildGold,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildLegendItem(context, AppTheme.completedGreen, '制覇済み'),
          const SizedBox(height: 5),
          _buildLegendItem(context, const Color(0xFFFFF3E0), '進行中'),
          const SizedBox(height: 5),
          _buildLegendItem(context, AppTheme.urgentRed, '緊急事態'),
          const SizedBox(height: 5),
          _buildLegendItem(context, AppTheme.paperYellow, '未着手'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: AppTheme.guildBeige, width: 1),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.textLight,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
