import 'package:flutter/material.dart';
import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/theme.dart';
import 'package:nike/ui/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const defultTextStyle = TextStyle(
        fontFamily: 'IranYekan', color: LightThemeColors.primaryTextColor);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
            contentTextStyle: defultTextStyle.apply(color: Colors.white)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: LightThemeColors.primaryTextColor),
        textTheme: TextTheme(
            titleMedium: defultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor),
            bodyMedium: defultTextStyle,
            labelLarge: defultTextStyle,
            bodySmall: defultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor),
            titleLarge: defultTextStyle.copyWith(
                fontWeight: FontWeight.w700, fontSize: 18)),
        colorScheme: const ColorScheme.light(
            primary: LightThemeColors.primaryColor,
            secondary: LightThemeColors.secondaryColor,
            onSecondary: Colors.white),
        useMaterial3: true,
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: RootScreen()),
    );
  }
}
