import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../views/home/home_screen.dart';
import '../../views/map/map_screen.dart';
import '../../views/quest/quest_execution_screen.dart';
import '../../views/area/area_detail_screen.dart';
import '../../views/stats/stats_screen.dart';
import '../../views/settings/settings_screen.dart';

class AppRoutes {
  // ルート名の定数
  static const String home = '/';
  static const String map = '/map';
  static const String questExecution = '/quest-execution';
  static const String areaDetail = '/area-detail';
  static const String stats = '/stats';
  static const String settings = '/settings';

  // GoRouter の設定
  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      // ホーム画面（ギルドホーム）
      GoRoute(
        path: home,
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // マップ画面（冒険マップ）
      GoRoute(
        path: map,
        name: 'map',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const MapScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),

      // クエスト実行画面
      GoRoute(
        path: questExecution,
        name: 'questExecution',
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return CustomTransitionPage(
            key: state.pageKey,
            child: QuestExecutionScreen(
              roomId: extra?['roomId'] as String?,
              roomName: extra?['roomName'] as String?,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
          );
        },
      ),

      // エリア詳細画面
      GoRoute(
        path: areaDetail,
        name: 'areaDetail',
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return CustomTransitionPage(
            key: state.pageKey,
            child: AreaDetailScreen(roomId: extra?['roomId'] as String? ?? ''),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0.0, 1.0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                    child: child,
                  );
                },
          );
        },
      ),

      // 統計・分析画面
      GoRoute(
        path: stats,
        name: 'stats',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const StatsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // 設定画面
      GoRoute(
        path: settings,
        name: 'settings',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SettingsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
    ],

    // エラーハンドリング
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'ページが見つかりません',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(home),
              child: const Text('ホームに戻る'),
            ),
          ],
        ),
      ),
    ),
  );

  // ヘルパーメソッド：パラメータ付き遷移
  static void goToAreaDetail(BuildContext context, String roomId) {
    context.push(areaDetail, extra: {'roomId': roomId});
  }

  static void goToQuestExecution(
    BuildContext context, {
    String? roomId,
    String? roomName,
  }) {
    context.push(
      questExecution,
      extra: {'roomId': roomId, 'roomName': roomName},
    );
  }
}
