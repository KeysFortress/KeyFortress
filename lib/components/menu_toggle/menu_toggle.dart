import 'package:domain/models/component_action.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:localization/localization.dart';

class MenuToggle extends ComponentActionViewModel {
  GetIt getIt = GetIt.I;
  late BuildContext _context;
  late IPageRouterService _routerService;

  MenuToggle(BuildContext context) {
    _context = context;
    _routerService = getIt.get<IPageRouterService>();
  }

  bool _isActive = false;
  @override
  bool get isActive => _isActive;

  @override
  String? get title => "Menu".i18n();

  @override
  String? get icon => "assets/images/menu-dashboard.svg";

  String? _statusMessage = "";
  @override
  String? get statusMessage => _statusMessage;

  @override
  Color? get defaultMessageColor => ThemeStyles.theme.text200;

  @override
  ready() async {
    return super.ready();
  }

  @override
  onPresssed() {
    _routerService.changePage(
      "/set-global-app-lock",
      _context,
      TransitionData(next: PageTransition.slideForward),
    );

    notifyListeners();
  }
}
