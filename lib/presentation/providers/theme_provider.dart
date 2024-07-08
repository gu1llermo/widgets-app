import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// un simple boolean
final isDarkModeProvider = StateProvider<bool>((ref) => false);

// son pequeñas piezas de estado

// un simple int
final selectedColorProvider = StateProvider<int>((ref) => 0);

// listado de colores inmutables
final colorlistProvider = Provider((ref) => colors);
// es para valores inmutables
// es constante y no cambiará
// desde que se creó ésta variable

// un objeto de tipo AppTheme (custom)
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

// el ThemeNotifier es un controlador, y controla a AppTheme
class ThemeNotifier extends StateNotifier<AppTheme> {
  // éste StateNotifier se vá a encargar de mantener un estado en particular
  // especificamente quiere mantener una instancia de AppTheme

  ThemeNotifier() : super(AppTheme()); // me imagino que es lo mismo
  // ThemeNotifier(super.state);

  // STATE = Estado = new AppTheme()

  void toggleDarkMode() {
    state = state.copyWith(darkMode: !state.darkMode);
  }

  void changeColorIndex(int index) {
    state = state.copyWith(selectedColor: index);
  }
}
