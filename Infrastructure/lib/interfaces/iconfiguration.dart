import 'package:domain/models/app_config.dart';

abstract class IConfiguration {
  AppConfig? config;

  Future<AppConfig> getConfig();
  Future<bool> overrideConfig();
}
