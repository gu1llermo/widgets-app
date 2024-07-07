import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

final isDarkModeProvider = StateProvider<bool>((ref) => false);

// listado de colores inmutables
final colorlistProvider = Provider((ref) => colors);
// es constante y no cambiará
// desde que se creó ésta variable

final selectedColorProvider = StateProvider<int>((ref) => 0);
