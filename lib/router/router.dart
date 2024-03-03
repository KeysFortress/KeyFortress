import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/views/add_otp_code/add_otp_code_view.dart';
import 'package:presentation/views/add_otp_secret/add_otp_secret.dart';
import 'package:presentation/views/connect_device_screen/connect_device_screen_view.dart';
import 'package:presentation/views/connection_list/connection_list.dart';
import 'package:presentation/views/device/device_view.dart';
import 'package:presentation/views/establish_connection/establish_connection.dart';
import 'package:presentation/views/identities/identities_view.dart';
import 'package:presentation/views/identity_history/identity_history_view.dart';
import 'package:presentation/views/passwords/passwords_view.dart';
import 'package:presentation/views/set_pin_number/set_pin_number.dart';
import 'package:presentation/views/setup_locking/setup_locking.dart';
import 'package:presentation/views/setup_pattern/setup_pattern.dart';
import 'package:presentation/views/setup_totp_lock/setup_totp_lock.dart';
import 'package:presentation/views/start_auth/start_auth_view.dart';
import 'package:presentation/views/totp/totp_view.dart';
import 'package:shared/unlock_panel/unlock_panel_view.dart';

class ApplicationRouter {
  //Animations Handles

  static SlideTransition slideTransionHandle(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    bool direction,
  ) {
    late final Animation<Offset> offsetAnimation;

    if (direction) {
      offsetAnimation = Tween<Offset>(
        begin: const Offset(1.5, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ));
    } else {
      offsetAnimation = Tween<Offset>(
        begin: const Offset(-1.5, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ));
    }

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  static FadeTransition fadeTransision(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    bool direction,
  ) {
    late final Animation<double> fadeAnimation = CurvedAnimation(
      parent: animation,
      curve: direction ? Curves.easeInOut : Curves.easeOut,
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: child,
    );
  }

  static final List<(String, dynamic, int, Duration)> _routes = [
    (
      "start-auth",
      StartAuthView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "identity-history",
      IdentityHistoryView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "Authenticate/:id/:path",
      IdentityHistoryView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "totp",
      TotpView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "add-totp",
      AddOtpCodeView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "add-manual-totp",
      AddOtpSecret(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "passwords",
      PasswordsView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "identities",
      IdentititesView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "connect-devices",
      ConnectDeviceScreenView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "device",
      DeviceView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "connection-list",
      ConnectionListView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "establish-connection",
      EstablishConnectionView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "unlock-device",
      UnlockPanelView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "setup-lock",
      SetupLockingView(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "setup-pin",
      SetPinNumber(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "setup-pattern",
      SetupPattern(),
      1,
      Duration(milliseconds: 500),
    ),
    (
      "setup-totp-lock",
      SetupTotpLock(),
      1,
      Duration(milliseconds: 500),
    ),
  ];

  static const Duration animationDuration = Duration(milliseconds: 500);
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return UnlockPanelView();
        },
        routes: <RouteBase>[
          ..._routes
              .map(
                (e) => GoRoute(
                  path: e.$1,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      maintainState: true,
                      key: state.pageKey,
                      transitionDuration: e.$4,
                      child: PopScope(
                        canPop: true,
                        onPopInvoked: (b) async {
                          // GetIt.I
                          //     .get<IPageRouterService>()
                          //     .backToPrevious(context);
                        },
                        child: e.$2,
                      ),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) =>
                          tranisitionController(
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                        state,
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ],
      ),
    ],
  );

  static tranisitionController(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      GoRouterState state) {
    var caller = state.extra as TransitionData;
    print(state.path);
    if (caller.next == PageTransition.easeInAndOut) {
      return fadeTransision(
          context, animation, secondaryAnimation, child, true);
    }

    if (caller.next == PageTransition.slideBack) {
      return slideTransionHandle(
        context,
        animation,
        secondaryAnimation,
        child,
        false,
      );
    }

    if (caller.next == PageTransition.slideForward) {
      return slideTransionHandle(
        context,
        animation,
        secondaryAnimation,
        child,
        true,
      );
    }

    return child;
  }
}

class CustomFadeAnimation extends CurvedAnimation {
  final double min;
  final double max;

  CustomFadeAnimation({
    required super.parent,
    required super.curve,
    super.reverseCurve,
    required this.min,
    required this.max,
  });

  @override
  double get value {
    double valueFromParent = super.value;
    double range = max - min;

    return min + valueFromParent * range;
  }
}
