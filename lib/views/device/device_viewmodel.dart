import 'dart:convert';

import 'package:domain/models/device.dart';
import 'package:domain/models/device_sync_event.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/otp_code.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:domain/models/stored_secret.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:shared/page_view_model.dart';
import 'package:components/sync_data_picker/sync_data_picker.dart';
import 'package:infrastructure/interfaces/isync_service.dart';
import 'package:components/one_time_data_picker/one_time_data_picker.dart';

class DeviceViewModel extends PageViewModel {
  late ISyncService _syncService;
  late IOtpService _otpService;
  String _deviceName = "";
  get deviceName => _deviceName;
  late Device _device;

  SyncTypes _activeType = SyncTypes.otc;
  SyncTypes get activeType => _activeType;

  List<DeviceSyncEvent> _syncEvents = [];
  List<DeviceSyncEvent> get syncEvents => _syncEvents;

  DeviceViewModel(super.context) {
    _syncService = getIt.get<ISyncService>();
    _otpService = getIt.get<IOtpService>();
  }

  ready() async {
    _device = router.getPageBindingData() as Device;
    _deviceName = _device.name;
    _activeType = await _syncService.getSyncType(_device.mac);
    _syncEvents = await _syncService.getSyncLog(_device.mac);

    notifyListeners();
  }

  fullSyncPreessed() async {
    _device.syncType = SyncTypes.full;
    _activeType = SyncTypes.full;

    await _syncService.setSyncType(_device.mac, SyncTypes.full);
    await _syncService.synchronize(_device);
    notifyListeners();
  }

  onPartialSync() {
    router.openBar(
      SyncDataPicker(
        deviceId: _device.mac,
        onSelected: onSyncDataSelected,
      ),
      pageContext,
    );
  }

  onSyncDataSelected() async {
    _device.syncType = SyncTypes.partial;
    _activeType = SyncTypes.partial;

    await _syncService.setSyncType(_device.mac, SyncTypes.partial);
    await _syncService.synchronize(_device);
    notifyListeners();
  }

  onOneTimeSelected() {
    router.openBar(
      OneTimeDataPicker(
        onSelected: onOneTimePicked,
      ),
      pageContext,
    );
  }

  onOneTimePicked(dynamic data) async {
    var type = data['type'];
    var content = "";
    switch (type) {
      case 1:
        content = (data['data'] as StoredSecret).content;
        break;
      case 2:
        var codeData = (data['data'] as OtpCode);
        var code = _otpService.getCode(
          codeData.secret,
          codeData.interval ?? 30,
          codeData.algorithm,
        );
        content = code;
        break;
      case 3:
        content = jsonEncode((data['data'] as StoredIdentity).toJson());
        break;
    }

    await _syncService.oneTimeSync(_device, content);
    router.dismissBar(pageContext);
  }

  getSyncType(int type) {
    switch (type) {
      case 1:
        return "Full";
      case 2:
        return "Partial";
      case 3:
        return "OTC";
    }
  }
}
