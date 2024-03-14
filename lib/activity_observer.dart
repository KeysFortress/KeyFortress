import 'dart:async';

import 'package:domain/models/enums.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:infrastructure/interfaces/idevices_service.dart';
import 'package:infrastructure/interfaces/iobserver.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:infrastructure/interfaces/isync_service.dart';
import 'package:shared/locator.dart';

class ActivityObserver with WidgetsBindingObserver {
  static const int _inactivityThresholdSeconds = 60;
  static const int _syncThresholdSeconds = 60;
  late Timer _inactivityTimer;
  late Timer _syncTimer;
  late IPageRouterService _routerService;
  late IAuthorizationService _authorizationService;
  late ISyncService _syncService;
  late IDevicesService _devicesService;

  late IObserver _observer;

  ActivityObserver() {
    WidgetsBinding.instance.addObserver(this);
    GestureBinding.instance.pointerRouter
        .addGlobalRoute(_globalUserInteractionHandler);

    _routerService = getIt.get<IPageRouterService>();
    _observer = getIt.get<IObserver>();
    _authorizationService = getIt.get<IAuthorizationService>();
    _syncService = getIt.get<ISyncService>();
    _devicesService = getIt.get<IDevicesService>();
    _observer.subscribe("on_sync_event", onSyncEvent);
    _startInactivityTimer();
    _startSyncTimer();
  }

  void _startInactivityTimer() {
    _inactivityTimer = Timer.periodic(
      Duration(seconds: _inactivityThresholdSeconds),
      (timer) async {
        var lockType = await _authorizationService.getDeviceLockType();
        if (lockType == DeviceLockType.none) return;

        if (_routerService.router.router.location == "/lock") return;
        _routerService.isLocked = true;
        _routerService.router.router.replace("/lock");
      },
    );
  }

  void _startSyncTimer() {
    _syncTimer = Timer.periodic(
      Duration(seconds: _syncThresholdSeconds),
      (timer) async {
        await onSyncEvent();
      },
    );
  }

  void _resetInactivityTimer() {
    _inactivityTimer.cancel();
    _startInactivityTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        var lockType = await _authorizationService.getDeviceLockType();
        if (lockType == DeviceLockType.none) return;

        if (_routerService.router.router.location == "/lock") return;
        _routerService.isLocked = true;
        _routerService.router.router.replace("/lock");
    }
  }

  void _globalUserInteractionHandler(PointerEvent event) {
    _resetInactivityTimer();
  }

  onSyncEvent() {
    //TODO add check if sync on action is enabled once the settings are done.
    Future.microtask(() async {
      var devices = await _devicesService.all();
      for (var element in devices) {
        await _syncService.synchronize(element);
      }
    });
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _inactivityTimer.cancel();
    _syncTimer.cancel();
  }
}
