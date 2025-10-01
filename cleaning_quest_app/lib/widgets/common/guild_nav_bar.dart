import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_theme.dart';
import '../../app/routes/app_routes.dart';

class GuildNavBar extends StatelessWidget {
  final int currentIndex;

  const GuildNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3E2723).withOpacity(0.95),
            const Color(0xFF5D4037).withOpacity(0.9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: const Border(
          top: BorderSide(color: AppTheme.guildBeige, width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: '🏠',
                label: 'ギルド',
                index: 0,
                route: AppRoutes.home,
              ),
              _buildNavItem(
                context,
                icon: '🗺️',
                label: 'マップ',
                index: 1,
                route: AppRoutes.map,
              ),
              _buildNavItem(
                context,
                icon: '📊',
                label: '記録書',
                index: 2,
                route: AppRoutes.stats,
              ),
              _buildNavItem(
                context,
                icon: '⚙️',
                label: '管理室',
                index: 3,
                route: AppRoutes.settings,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String icon,
    required String label,
    required int index,
    required String route,
  }) {
    final bool isActive = currentIndex == index;

    return InkWell(
      onTap: () {
        if (!isActive) {
          context.go(route);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive
              ? AppTheme.guildGold.withOpacity(0.15)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // アイコン
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: isActive ? 1.2 : 1.0),
              duration: const Duration(milliseconds: 200),
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Text(
                    icon,
                    style: TextStyle(
                      fontSize: 20,
                      shadows: isActive
                          ? [
                              Shadow(
                                color: AppTheme.guildGold.withOpacity(0.8),
                                blurRadius: 10,
                              ),
                            ]
                          : null,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            // ラベル
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? AppTheme.guildGold : AppTheme.textLight,
                shadows: isActive
                    ? [
                        Shadow(
                          color: AppTheme.guildGold.withOpacity(0.5),
                          blurRadius: 5,
                        ),
                      ]
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
