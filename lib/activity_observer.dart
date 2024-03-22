import 'dart:async';
import 'package:domain/models/enums.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:infrastructure/interfaces/iobserver.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:infrastructure/interfaces/isync_service.dart';
import 'package:shared/locator.dart';

class ActivityObserver with WidgetsBindingObserver {
  late Timer _inactivityTimer;
  late Timer _syncTimer;
  late IPageRouterService _routerService;
  late IAuthorizationService _authorizationService;
  late ISyncService _syncService;
  late IObserver _observer;

  bool _isTimerLockEnabled = true;
  bool _lockOnMinimize = false;
  bool _isTimeSyncEnabled = true;

  static const int _inactivityThresholdSeconds = 60;
  static int _syncThresholdSeconds = 60;

  ActivityObserver() {
    WidgetsBinding.instance.addObserver(this);
    GestureBinding.instance.pointerRouter
        .addGlobalRoute(_globalUserInteractionHandler);

    _routerService = getIt.get<IPageRouterService>();
    _observer = getIt.get<IObserver>();
    _authorizationService = getIt.get<IAuthorizationService>();
    _syncService = getIt.get<ISyncService>();

    _observer.subscribe("sync_timer_time_changed", onSyncStateTimeUpdated);
    _observer.subscribe("sync_timer_state_changed", onSyncTimeStateChanged);
    _observer.subscribe("timer_disabled", onTimerChanged);
    _observer.subscribe("minimize_disabled", onMinimizeChanged);
    _authorizationService.isTimeLockEnabled().then(
      (value) {
        _isTimerLockEnabled = value;
        if (value) _startInactivityTimer();
      },
    );

    _authorizationService.isMinimizeLockEnabled().then(
      (value) {
        _lockOnMinimize = value;
      },
    );

    _syncService.getGlobalSettings().then(
      (value) {
        _isTimeSyncEnabled = value['OnAction'] && value["timeBasedSync"];
        if (_isTimeSyncEnabled) {
          _syncThresholdSeconds = value["updateTime"];
          _startSyncTimer();
        }
      },
    );
  }

  void _startInactivityTimer() {
    _inactivityTimer = Timer.periodic(
      Duration(seconds: _inactivityThresholdSeconds),
      (timer) async {
        if (!_isTimerLockEnabled) return;

        var lockType = await _authorizationService.getDeviceLockType();
        if (lockType == DeviceLockType.none) return;

        if (_routerService.router.router.location == "/lock") return;
        _routerService.isLocked = true;
        if (_routerService.isBoxOpen)
          _routerService.dismissBar(_routerService.lastContext);

        _routerService.router.router.replace("/lock");
      },
    );
  }

  void _startSyncTimer() {
    _syncTimer = Timer.periodic(
      Duration(seconds: _syncThresholdSeconds),
      (timer) async {
        _observer.getObserver("sync_changes", null);
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
        if (!_lockOnMinimize) return;

        var lockType = await _authorizationService.getDeviceLockType();
        if (lockType == DeviceLockType.none) return;

        if (_routerService.router.router.location == "/lock") return;
        _routerService.isLocked = true;
        if (_routerService.isBoxOpen)
          _routerService.dismissBar(_routerService.lastContext);

        _routerService.router.router.replace("/lock");
    }
  }

  void _globalUserInteractionHandler(PointerEvent event) {
    if (_isTimerLockEnabled) _resetInactivityTimer();
  }

  onTimerDisabled() {}

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _inactivityTimer.cancel();
    _syncTimer.cancel();
  }

  onTimerChanged(bool state) {
    if (state) {
      _inactivityTimer.cancel();
      _isTimerLockEnabled = true;
      _startInactivityTimer();

      return;
    }
    _isTimerLockEnabled = false;
    _inactivityTimer.cancel();
  }

  onMinimizeChanged(bool state) {
    _lockOnMinimize = state;
  }

  onSyncTimeStateChanged(bool value) {
    _isTimeSyncEnabled = value;
    _syncTimer.cancel();

    _startSyncTimer();
  }

  onSyncStateTimeUpdated(int timeToSync) {
    _syncTimer.cancel();
    _syncThresholdSeconds = timeToSync;

    _startSyncTimer();
  }
}
