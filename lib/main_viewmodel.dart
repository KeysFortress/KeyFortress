import 'dart:async';

import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/core_router.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:domain/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/interfaces/iexception_manager.dart';
import 'package:infrastructure/interfaces/iobserver.dart';
import "package:infrastructure/interfaces/ipage_router_service.dart";
import 'package:stacked/stacked.dart';
import 'package:shared/locator.dart' as locator;

class MainViewModel extends BaseViewModel with WidgetsBindingObserver {
  late BuildContext _context;
  GetIt getIt = locator.getIt;
  late IPageRouterService routerService;
  late MaterialApp _app;
  late IExceptionManager _exceptionManager;
  late bool? _isConfigured;
  bool? get isConfigured => _isConfigured;
  MaterialApp get app => _app;
  late CoreRouter? _router;
  CoreRouter? get router => _router;
  StreamSubscription<Uri>? _linkSubscription;
  late IObserver _observer;
  bool isMenuVisible = true;
  bool isBottomMenuVisible = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App is in the foreground
      // Perform tasks you want to execute when the app comes to the foreground
      print("App is in the foreground");
      routerService.router.router.go("/");
    }
  }

  initialized(CoreRouter router, BuildContext context) async {
    WidgetsBinding.instance.addObserver(this);
    _context = context;
    _router = router;
    _exceptionManager = getIt.get<IExceptionManager>();
    _observer = getIt.get<IObserver>();
    _observer.subscribe("on_menu_state_changed", onMenuStateChanged);
    routerService = getIt.get<IPageRouterService>();
    routerService.registerRouter(router);
    var deviceDimensions = MediaQuery.of(context).size;
    ThemeStyles.width = deviceDimensions.width;
    ThemeStyles.height = deviceDimensions.height;

    registerGlobalExceptionHandler();
    notifyListeners();
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  onMenuStateChanged(bool state) {
    isMenuVisible = state;
    isBottomMenuVisible = state;
    Future.delayed(Duration(milliseconds: 200), () {
      notifyListeners();
    });
  }
}
