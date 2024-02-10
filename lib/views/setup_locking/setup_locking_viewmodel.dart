import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:presentation/views/setup_locking/locking_options/biometric_not_supported/biometric_option.dart';
import 'package:presentation/views/setup_locking/locking_options/biometric_option/biometric_option.dart';
import 'package:presentation/views/setup_locking/locking_options/pattern_option/pattern_option.dart';
import 'package:presentation/views/setup_locking/locking_options/pin_option/pin_option.dart';
import 'package:presentation/views/setup_locking/locking_options/totp_option/totp_option.dart';
import 'package:shared/page_view_model.dart';

class SetupLockingViewModel extends PageViewModel {
  List<Widget> _lockOptions = [];
  List<Widget> get lockOptions => _lockOptions;
  int _selectedOption = 0;
  int get selectedOption => _selectedOption;

  SetupLockingViewModel(super.context);
  final LocalAuthentication auth = LocalAuthentication();

  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  ready() async {
    var biometricSupported = await auth.isDeviceSupported();
    _lockOptions = [
      biometricSupported ? BiometricOption() : BiometricNotSupported(),
      PinOption(),
      PatternOption(),
      TotpOption(),
    ];
  }

  void changePosition(int index) {
    Future.delayed(Duration(milliseconds: 200), () {
      int scrollPosition =
          (_scrollController.offset / ThemeStyles.width!).round();
      _selectedOption = scrollPosition;
      notifyListeners();
    });
  }
}
