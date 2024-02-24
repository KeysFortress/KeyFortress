import 'dart:async';

import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/core_router.dart';

import 'package:domain/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/interfaces/iconfiguration.dart';
import 'package:infrastructure/interfaces/iexception_manager.dart';
import 'package:infrastructure/interfaces/ihttp_server.dart';
import 'package:infrastructure/interfaces/ilogging_service.dart';
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
  late IHttpServer _httpServer;
  late IConfiguration _configuration;
  bool? get isConfigured => _isConfigured;
  MaterialApp get app => _app;
  late CoreRouter? _router;
  CoreRouter? get router => _router;
  StreamSubscription<Uri>? _linkSubscription;
  late IObserver _observer;
  bool isMenuVisible = true;
  bool isBottomMenuVisible = true;
  late ILoggingService _loggingService = locator.getIt.get<ILoggingService>();

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
    try {
      WidgetsBinding.instance.addObserver(this);
      _context = context;
      _router = router;
      _configuration = getIt.get<IConfiguration>();
      await _configuration.load();
      _exceptionManager = getIt.get<IExceptionManager>();
      _observer = getIt.get<IObserver>();
      _httpServer = getIt.get<IHttpServer>();
      _observer.subscribe("on_menu_state_changed", onMenuStateChanged);
      routerService = getIt.get<IPageRouterService>();
      routerService.registerRouter(router);
      var deviceDimensions = MediaQuery.of(context).size;
      ThemeStyles.width = deviceDimensions.width;
      ThemeStyles.height = deviceDimensions.height;
      _httpServer.startServer();
      registerGlobalExceptionHandler();
      notifyListeners();
    } catch (ex) {
      _loggingService.exception(ex.toString());
    }
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

  Timer? timer;
  void resetTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 30), (timer) {
      routerService.router.router.go("/");
    });
  }
}
