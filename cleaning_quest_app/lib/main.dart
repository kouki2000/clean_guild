import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/map_viewmodel.dart';
import 'viewmodels/quest_execution_viewmodel.dart';
import 'viewmodels/area_detail_viewmodel.dart';
import 'viewmodels/stats_viewmodel.dart';
import 'viewmodels/settings_viewmodel.dart';

void main() {
  runApp(const CleaningQuestApp());
}

class CleaningQuestApp extends StatelessWidget {
  const CleaningQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => HomeViewModel()),
        // ChangeNotifierProvider(create: (_) => MapViewModel()),
        // ChangeNotifierProvider(create: (_) => QuestExecutionViewModel()),
        // ChangeNotifierProvider(create: (_) => AreaDetailViewModel()),
        // ChangeNotifierProvider(create: (_) => StatsViewModel()),
        // ChangeNotifierProvider(create: (_) => SettingsViewModel()),
      ],
      child: MaterialApp.router(
        title: '掃除の冒険者ギルド',
        // theme: AppTheme.guildTheme,
        // routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
