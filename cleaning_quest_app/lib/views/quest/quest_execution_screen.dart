import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../app/theme/app_theme.dart';
import '../../app/routes/app_routes.dart';

class QuestExecutionScreen extends StatefulWidget {
  final String? roomId;
  final String? roomName;

  const QuestExecutionScreen({super.key, this.roomId, this.roomName});

  @override
  State<QuestExecutionScreen> createState() => _QuestExecutionScreenState();
}

class _QuestExecutionScreenState extends State<QuestExecutionScreen> {
  bool isTimerRunning = false;
  int timeRemaining = 25 * 60 + 30; // 25分30秒
  Timer? timer;
  int completedTasks = 1;
  final int totalTasks = 4;
  int earnedEXP = 20;

  final List<Map<String, dynamic>> tasks = [
    {'name': '食器を洗う', 'exp': 20, 'completed': true},
    {'name': 'コンロを掃除する', 'exp': 30, 'completed': false},
    {'name': 'シンクを磨く', 'exp': 25, 'completed': false},
    {'name': '床を拭く', 'exp': 15, 'completed': false},
  ];

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (!isTimerRunning) {
      setState(() {
        isTimerRunning = true;
      });

      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (timeRemaining > 0) {
          setState(() {
            timeRemaining--;
          });
        } else {
          t.cancel();
          _showCompletionDialog();
        }
      });
    }
  }

  void pauseTimer() {
    timer?.cancel();
    setState(() {
      isTimerRunning = false;
    });
  }

  void stopTimer() {
    timer?.cancel();
    _showCompletionDialog();
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];

      if (tasks[index]['completed']) {
        completedTasks++;
        earnedEXP += tasks[index]['exp'] as int;
      } else {
        completedTasks--;
        earnedEXP -= tasks[index]['exp'] as int;
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.paperYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppTheme.guildBeige, width: 3),
        ),
        title: const Text(
          '🏆 クエスト完了！',
          style: TextStyle(
            color: AppTheme.textDark,
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '素晴らしい働きだった！',
              style: TextStyle(color: AppTheme.textMedium),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: AppTheme.goldBadge,
              child: Column(
                children: [
                  Text(
                    '獲得EXP: $earnedEXP',
                    style: const TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '完了タスク: $completedTasks/$totalTasks',
                    style: const TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go(AppRoutes.home);
            },
            child: const Text('ギルドに戻る'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString()}:${secs.toString().padLeft(2, '0')}';
  }

  double get _timerProgress {
    const totalTime = 25 * 60 + 30;
    return (totalTime - timeRemaining) / totalTime;
  }

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
                      const SizedBox(height: 30),
                      _buildTimerSection(),
                      const SizedBox(height: 20),
                      _buildTaskSection(),
                      const SizedBox(height: 20),
                      _buildProgressSection(),
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
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
              const Text('⚔️', style: TextStyle(fontSize: 24)),
              Expanded(
                child: Text(
                  widget.roomName ?? '台所の洞窟征服',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
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
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Text(
              'HARD',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // タイマーセクション
  Widget _buildTimerSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // タイマーリング
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // プログレスリング
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: _timerProgress,
                    strokeWidth: 12,
                    backgroundColor: AppTheme.guildBrownLight.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppTheme.guildGold,
                    ),
                  ),
                ),
                // タイマー表示
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.paperYellow, AppTheme.paperYellowLight],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.guildBeige, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatTime(timeRemaining),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE65100),
                          fontFamily: 'Georgia',
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '残り時間',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // コントロールボタン
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isTimerRunning)
                ElevatedButton.icon(
                  onPressed: startTimer,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('開始'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                )
              else
                ElevatedButton.icon(
                  onPressed: pauseTimer,
                  icon: const Icon(Icons.pause),
                  label: const Text('一時停止'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9800),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              const SizedBox(width: 15),
              ElevatedButton.icon(
                onPressed: stopTimer,
                icon: const Icon(Icons.check),
                label: const Text('完了'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // タスクセクション
  Widget _buildTaskSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.guildPanel,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('📋', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                '征服タスク',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.guildGold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...List.generate(tasks.length, (index) {
            final task = tasks[index];
            final isCompleted = task['completed'] as bool;

            return GestureDetector(
              onTap: () => toggleTask(index),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isCompleted
                        ? [AppTheme.completedGreen, AppTheme.completedGreenDark]
                        : [AppTheme.paperYellow, AppTheme.paperYellowLight],
                  ),
                  border: Border.all(
                    color: isCompleted
                        ? const Color(0xFF4CAF50)
                        : AppTheme.guildBeige,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? const Color(0xFF4CAF50)
                            : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.guildBeige,
                          width: 2,
                        ),
                      ),
                      child: isCompleted
                          ? const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task['name'] as String,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '獲得EXP: ${task['exp']}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppTheme.textMedium,
                                  fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // 進捗セクション
  Widget _buildProgressSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
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
                        '$earnedEXP',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE65100),
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        '獲得EXP',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Container(
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
                        '$completedTasks/$totalTasks',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE65100),
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        '完了タスク',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppTheme.guildBrownLight.withOpacity(0.6),
              border: Border.all(color: AppTheme.guildBeige, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  'クエスト進捗',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.guildGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D342F).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppTheme.guildBeige, width: 1),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: completedTasks / totalTasks,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.guildGold, AppTheme.guildOrange],
                        ),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.guildGold.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
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
}
