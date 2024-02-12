import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';

import '../screens/game_ground_screen.dart';
import '../screens/game_settings_screen.dart';
import '../screens/game_history_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'game_settings',
          builder: (context, state) => const GameSettingsScreen(),
        ),
        GoRoute(
          path: 'game_history',
          builder: (context, state) => const GameHistoryScreen(),
        )
      ],
    ),
    GoRoute(
      path: '/game_ground',
      builder: (context, state) => const GameGroundScreen(),
    ),
  ],
);
