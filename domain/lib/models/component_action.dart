import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

abstract class ComponentActionViewModel extends BaseViewModel {
  Color? defaultMessageColor;
//
  onPresssed();
  String? icon;
  String? title;
  String? statusIcon;
  String? statusMessage;
  Color? statusColor;
  bool isActive = false;

  ready() {}
}
