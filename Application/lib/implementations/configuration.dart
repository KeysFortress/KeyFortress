import 'dart:convert';

import 'package:domain/models/app_config.dart';
import 'package:infrastructure/interfaces/iconfiguration.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';

class Configuration implements IConfiguration {
  IlocalStorage storage;

  Configuration({required this.storage});

  @override
  Future<AppConfig> getConfig() async {
    var existingOverride = await storage.get("Config");
    if (existingOverride == null) return await AppConfig.load();

    if (existingOverride.isEmpty) {
      return await AppConfig.load();
    }

    var map = jsonDecode(existingOverride);
    var current = AppConfig.fromJson(map);
    config = current;
    return current;
  }

  @override
  Future<bool> overrideConfig() {
    // TODO: implement overrideConfig
    throw UnimplementedError();
  }

  @override
  AppConfig? config;
}
