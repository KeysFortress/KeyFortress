import 'package:flutter/material.dart';
import 'package:presentation/views/setup_locking/locking_options/biometric_option/biometric_option.dart';
import 'package:presentation/views/setup_locking/locking_options/pattern_option/pattern_option.dart';
import 'package:presentation/views/setup_locking/locking_options/pin_option/pin_option.dart';
import 'package:presentation/views/setup_locking/locking_options/totp_option/totp_option.dart';
import 'package:shared/page_view_model.dart';

class SetupLockingViewModel extends PageViewModel {
  List<Widget> _lockOptions = [
    BiometricOption(),
    PinOption(),
    PatternOption(),
    TotpOption(),
  ];
  List<Widget> get lockOptions => _lockOptions;
  int _selectedOption = 0;
  int get selectedOption => _selectedOption;

  SetupLockingViewModel(super.context);

  ready() {}

  void updateScrollIndex(int index) {
    _selectedOption = index;
    notifyListeners();
  }
}
