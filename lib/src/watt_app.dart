import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watt_charge_tracker/src/core/bindings/bindings.dart';
import 'package:watt_charge_tracker/src/core/constants/strings.dart';
import 'package:watt_charge_tracker/src/core/theme/app_theme.dart';
import 'package:watt_charge_tracker/src/core/theme/text_theme.dart';
import 'package:watt_charge_tracker/src/features/authentication/presentation/view/pages/login_page.dart';

class WattApp extends StatelessWidget {
  const WattApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      theme: ThemeData(
          primaryColor: AppTheme.primaryColor,
          primarySwatch: Colors.orange,
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(
            background: AppTheme.backgroundColor,
          ),
          textTheme: TextTheme(
            bodyMedium: AppTextTheme.bodyStyle,
          ),
          buttonTheme: const ButtonThemeData(
              minWidth: 160, buttonColor: AppTheme.primaryColor)),
      home: const LoginPage(),
    );
  }
}
