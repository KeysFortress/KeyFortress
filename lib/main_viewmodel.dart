import 'dart:async';

import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/core_router.dart';
import 'package:domain/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/interfaces/iexception_manager.dart';
import "package:infrastructure/interfaces/ipage_router_service.dart";
import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  late BuildContext _context;
  GetIt getIt = GetIt.instance;
  late IPageRouterService routerService;
  late MaterialApp _app;
  late IExceptionManager _exceptionManager;
  late bool? _isConfigured;
  bool? get isConfigured => _isConfigured;
  MaterialApp get app => _app;
  late CoreRouter? _router;
  CoreRouter? get router => _router;
  StreamSubscription<Uri>? _linkSubscription;

  initialized(CoreRouter router, BuildContext context) async {
    _context = context;
    _router = router;
    _exceptionManager = getIt.get<IExceptionManager>();
    routerService = getIt.get<IPageRouterService>();
    routerService.registerRouter(router);
    var deviceDimensions = MediaQuery.of(context).size;
    ThemeStyles.width = deviceDimensions.width;
    ThemeStyles.height = deviceDimensions.height;

    registerGlobalExceptionHandler();
    initUniLinks();
    notifyListeners();
  }

  Future<void> initUniLinks() async {
    // Handle link when app is in warm state (front or background)
  }

  List<Widget> intersperse(Iterable<Widget> list, Widget item) {
    final initialValue = <Widget>[];
    return list.fold(initialValue, (all, el) {
      if (all.isNotEmpty) all.add(item);
      all.add(el);
      return all;
    });
  }

  void registerGlobalExceptionHandler() async {
    PlatformDispatcher.instance.onError = (error, stack) {
      if (error is BaseException) {
        _exceptionManager.raisePopup(error);
      }
      print(error);
      return true;
    };
  }

  onBackAction() {
    routerService.backToPrevious(_context);
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }
}
