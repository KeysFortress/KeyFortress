import 'package:application/implementations/configuration.dart';
import 'package:application/implementations/exception_manager.dart';
import 'package:application/implementations/http_provider.dart';
import 'package:application/implementations/local_storage.dart';
import 'package:application/implementations/observer.dart';
import 'package:application/implementations/page_router_service.dart';
import 'package:application/implementations/secret_manager.dart';
import 'package:application/implementations/signature_service.dart';
import 'package:application/implementations/identity_manager.dart';
import 'package:application/implementations/signature_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/interfaces/iconfiguration.dart';
import 'package:infrastructure/interfaces/iexception_manager.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/iidentity_manager.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/iobserver.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:infrastructure/interfaces/isignature_store.dart';

GetIt getIt = GetIt.I;
void registerDependency() async {
  getIt.registerSingleton<IHttpProviderService>(HttpProvider());
  getIt.registerSingleton<IExceptionManager>(ExceptionManager());
  getIt.registerSingleton<IObserver>(Observer());
  getIt.registerLazySingleton<IPageRouterService>(() {
    IObserver observer = getIt<IObserver>();
    return PageRouterService(observer);
  });
  getIt.registerSingleton<IlocalStorage>(LocalStorage());
  getIt.registerSingleton<ISignatureService>(SignatureService());
  getIt.registerLazySingleton<IConfiguration>(() {
    IlocalStorage localStorage = getIt<IlocalStorage>();
    var config = Configuration(storage: localStorage);
    config.getConfig().then((value) => config.config = value);
    return config;
  });
  getIt.registerLazySingleton<ISecretManager>(
    () {
      IlocalStorage _storage = getIt<IlocalStorage>();
      return SecretManger(
        localStorage: _storage,
      );
    },
  );
  getIt.registerLazySingleton<IIdentityManager>(
    () {
      IlocalStorage _storage = getIt<IlocalStorage>();
      ISignatureService signatureService = getIt<ISignatureService>();
      return IdentityManager(
        signatureService,
        _storage,
      );
    },
  );
  getIt.registerLazySingleton<ISignatureStore>(
    () {
      IlocalStorage _storage = getIt<IlocalStorage>();
      return SignatureStore(_storage);
    },
  );
}

void registerFactory<T>(FactoryFunc<T> func) {
  getIt.registerFactory(() => func);
}

void registerSingleton<T>(FactoryFunc<T> instance) {
  getIt.registerSingleton(instance);
}

void registerLazySingleton<T>(FactoryFunc<T> func) {
  getIt.registerLazySingleton(() => func);
}
