import 'dart:convert';

import 'package:domain/models/cloud_connection_code.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/icloud_service.dart';
import 'package:infrastructure/interfaces/idevices_service.dart';
import 'package:shared/page_view_model.dart';
import 'package:domain/models/device.dart';

class ConnectDeviceScreenViewModel extends PageViewModel {
  late IDevicesService _devicesService;
  late ICloudService _cloudService;
  List<Device> _devices = [];
  List<Device> get devices => _devices;

  List<CloudConnectionCode> _cloudConnections = [];
  List<CloudConnectionCode> get cloudConnections => _cloudConnections;

  ConnectDeviceScreenViewModel(super.context) {
    _devicesService = getIt.get<IDevicesService>();
    _cloudService = getIt.get<ICloudService>();
  }

  ready() async {
    _devices = await _devicesService.all();
    _cloudConnections = await _cloudService.connections();
    notifyListeners();
  }

  onAddPressed() {
    router.changePage(
      "/cloud-connect",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }

  onDeviceSelected(Device device) {
    router.changePage(
      "/device",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
      bindingData: device,
    );
  }

  onAddConnection() {
    router.changePage(
      "/connection-list",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }

  onConnectNewDevice() {}

  onRemoteConnection() async {
    var kp = await _cloudService.getOrCreateIdentity();
    var privateKeyData = await kp.extractPrivateKeyBytes();
    var publicKeyData = await kp.extractPublicKey();
    var privateKey = base64.encode(privateKeyData);
    var publicKey = base64.encode(publicKeyData.bytes);
    router.changePage(
      "/start-auth",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
      bindingData: StoredIdentity("", "cloud-connect", privateKey, publicKey),
    );
  }
}
