import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';

import '../screens/game_settings_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'game_settings',
          builder: (context, state) => const GameSettingsScreen(),
        )
      ],
    )
  ],
);
