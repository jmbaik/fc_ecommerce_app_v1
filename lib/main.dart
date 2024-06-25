import 'package:fc_ecommerce_app_v1/service_locator.dart';
import 'package:flutter/material.dart';

import 'core/theme/theme_data.dart';
import 'core/utils/exception/common_exception.dart';
import 'core/utils/logger.dart';
import 'data/data_source/mock/display/display_mock_api.dart';
import 'presentation/routes/routes.dart';

void main() async {
  setLocator();

  try {
    final test = await DisplayMockApi().getMenusByMallType('market');
    CustomLogger.logger.d(test);
  } catch (error) {
    final errorData = CommonException.setError(error);
    CustomLogger.logger.e(errorData);
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
    );
  }
}
