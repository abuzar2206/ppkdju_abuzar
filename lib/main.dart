import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'day_21/services/preference_service.dart';
import 'day_21/views/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);
  await PreferenceService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: PreferenceService.themeNotifier,
      builder: (context, currentThemeMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Absensi PPKD',
          themeMode: currentThemeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
            ),
          ),
          home: const SplashPage(),
        );
      },
    );
  }
}