import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../widgets/common/guild_nav_bar.dart';
import '../../app/theme/app_theme.dart';
import '../../app/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                      _buildAdventurerCard(context),
                      const SizedBox(height: 15),
                      _buildDailySummary(context),
                      const SizedBox(height: 15),
                      _buildQuestBoard(context),
                      const SizedBox(height: 15),
                      _buildDailyResults(context),
                      const SizedBox(height: 80), // ナビゲーションバー分の余白
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GuildNavBar(currentIndex: 0),
    );
  }

  // ヘッダー
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8B4513).withValues(alpha: .9),
            const Color(0xFFA0522D).withValues(alpha: 0.8),
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
              const Text('⚔️', style: TextStyle(fontSize: 24)),
              Text(
                '掃除の冒険者ギルド',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  shadows: AppTheme.goldTextShadow,
                ),
              ),
              const Text('🛡️', style: TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            '～ 清潔なる勇者たちの集い ～',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textLight,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // 冒険者カード
  Widget _buildAdventurerCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            children: [
              // アバター
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.guildGold, AppTheme.guildOrange],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.guildBeige, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.guildGold.withValues(alpha: 0.5),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('🤖', style: TextStyle(fontSize: 30)),
                ),
              ),
              const SizedBox(width: 15),
              // ユーザー情報
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '清掃騎士 ユーザー',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: AppTheme.guildGold),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'レベル 12 • 連続冒険 5日目',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // 経験値バー
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF4D342F).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppTheme.guildBeige, width: 1),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.65,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.guildGold, AppTheme.guildOrange],
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.guildGold.withValues(alpha: 0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 今日のサマリー
  Widget _buildDailySummary(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem(context, '23', '総クエスト数'),
          _buildSummaryItem(context, '18h', '総掃除時間'),
          _buildSummaryItem(context, '5日', '連続記録', showFire: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String value,
    String label, {
    bool showFire = false,
  }) {
    return Column(
      children: [
        if (showFire) const Text('🔥', style: TextStyle(fontSize: 24)),
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
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // クエスト掲示板
  Widget _buildQuestBoard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD7CCC8), Color(0xFFBCAAA4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppTheme.guildBeige, width: 4),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('📋', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                'クエスト掲示板',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontFamily: 'Georgia'),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildQuestPaper(
            context,
            title: '🔥 台所の洞窟征服',
            description: '強力な油汚れのボスが出現。緊急討伐求む！',
            reward: '80 EXP + 金貨袋',
            difficulty: 'HARD',
            isUrgent: true,
          ),
          const SizedBox(height: 10),
          _buildQuestPaper(
            context,
            title: '🛏️ 安らぎの聖域',
            description: '寝室の整理整頓を行い、平和を取り戻せ',
            reward: '45 EXP + 銀貨',
            difficulty: 'NORMAL',
          ),
          const SizedBox(height: 10),
          _buildQuestPaper(
            context,
            title: '✅ 憩いの広場',
            description: 'リビングの掃除完了。お疲れ様でした！',
            reward: '完了済み',
            difficulty: 'EASY',
            isCompleted: true,
          ),
        ],
      ),
    );
  }

  // クエスト用紙
  Widget _buildQuestPaper(
    BuildContext context, {
    required String title,
    required String description,
    required String reward,
    required String difficulty,
    bool isUrgent = false,
    bool isCompleted = false,
  }) {
    return GestureDetector(
      onTap: () {
        // エリア詳細画面に遷移
        AppRoutes.goToAreaDetail(context, 'kitchen');
      },
      child: Transform.rotate(
        angle: isUrgent ? -0.02 : 0.01,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isCompleted
                  ? [AppTheme.completedGreen, AppTheme.completedGreenDark]
                  : isUrgent
                  ? [AppTheme.urgentRed, AppTheme.urgentRedDark]
                  : [AppTheme.paperYellow, AppTheme.paperYellowLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: isCompleted
                  ? const Color(0xFF4CAF50)
                  : isUrgent
                  ? const Color(0xFFF44336)
                  : AppTheme.guildBeige,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
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
                    child: Text(
                      title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(fontFamily: 'Georgia'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: AppTheme.goldBadge.copyWith(
                      gradient: LinearGradient(
                        colors: [AppTheme.guildBeige, AppTheme.guildBrownLight],
                      ),
                    ),
                    child: Text(
                      difficulty,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                description,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: AppTheme.goldBadge,
                child: Text(
                  '報酬: $reward',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 本日の成果
  Widget _buildDailyResults(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('💰', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                '本日の冒険成果',
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
            children: [
              _buildResultItem(context, '156', '獲得EXP'),
              _buildResultItem(context, '89', '金貨'),
              _buildResultItem(context, '3', '制覇エリア'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(BuildContext context, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.paperYellowLight, Color(0xFFFFE082)],
        ),
        border: Border.all(color: AppTheme.guildGold, width: 2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: const Color(0xFFE65100)),
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
      ),
    );
  }
}
