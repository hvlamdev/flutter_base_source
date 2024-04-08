// GoRouter configuration
import 'package:base_source_flutter/features/weather/presentation/weather_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/${Routers.assistant}',
  routes: [
    GoRoute(
      name: Routers.assistant,
      path: '/${Routers.assistant}',
      builder: (context, state) => const WeatherScreen(),
    ),
  ],
);

class Routers {
  static const assistant = 'assistant';
  static const setting = 'setting';
}
