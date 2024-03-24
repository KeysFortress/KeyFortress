import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:domain/exceptions/base_exception.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:infrastructure/interfaces/icertificate_service.dart';
import 'package:infrastructure/interfaces/ilocal_network_service.dart';
import 'package:shared/page_view_model.dart';

class PairSettingsViewModel extends PageViewModel {
  late ICertificateService _certificateService;
  late ILocalNetworkService _localNetworkService;
  late IAuthorizationService _authorizationService;

  List<X509CertificateData>? _x509certificateData;
  List<X509CertificateData>? get certificateData => _x509certificateData;

  bool _pairEnabled = true;
  get pairEnabled => _pairEnabled;

  PairSettingsViewModel(super.context) {
    _certificateService = getIt.get<ICertificateService>();
    _localNetworkService = getIt.get<ILocalNetworkService>();
    _authorizationService = getIt.get<IAuthorizationService>();
  }

  int _currentPort = 2234;
  get currentPort => _currentPort;

  String _oldPassword = "";
  String get oldPassword => _oldPassword;

  String _password = "";

  ready() async {
    _x509certificateData = await _certificateService.read();
    _currentPort = await _localNetworkService.getPort();
    var certificatePassword = await _certificateService.getKeyPassword();
    //Obscure the password for the user if present.7
    if (certificatePassword != null) {
      for (var i = 0; i < certificatePassword.length; i++) {
        _oldPassword += "*";
      }
    }
    notifyListeners();
  }

  void onEnabledChanged(bool value) {}

  onPortNumberChanged(String number) async {
    if (number.isEmpty) return;

    await _localNetworkService.setPort(number);
    _currentPort = int.parse(number);
  }

  onUpdateCertificate() async {
    _authorizationService.setIgnoreState();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["zip"],
      type: FileType.custom,
    );

    if (result == null) return;

    List<File> files = result.paths.map((path) => File(path!)).toList();
    var content = await files.first;

    var imported = await _certificateService.importCertificate(content);
    if (!imported)
      throw BaseException(
        context: pageContext,
        message:
            "Failed to import certificate, zip may not contain a certificate and a private key!",
      );
    if (_password.isNotEmpty)
      await _certificateService.setCertificatePassword(_password);

    await ready();
  }

  onPrivateKeyPasswordChanged(String password) {
    _password = password;
  }
}
