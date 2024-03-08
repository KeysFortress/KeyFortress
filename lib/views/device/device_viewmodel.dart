import 'package:domain/models/device.dart';
import 'package:domain/models/enums.dart';
import 'package:shared/page_view_model.dart';
import 'package:infrastructure/interfaces/isync_service.dart';

class DeviceViewModel extends PageViewModel {
  late ISyncService _syncService;
  String _deviceName = "";
  get deviceName => _deviceName;
  late Device _device;

  SyncTypes _activeType = SyncTypes.otc;
  SyncTypes get activeType => _activeType;

  DeviceViewModel(super.context) {
    _syncService = getIt.get<ISyncService>();
  }

  ready() async {
    _device = router.getPageBindingData() as Device;
    _deviceName = _device.name;
    _activeType = await _syncService.getSyncType(_device.mac);

    notifyListeners();
  }

  fullSyncPreessed() {
    _device.syncType = SyncTypes.full;
    _syncService.setSyncType(_device.mac, SyncTypes.full);
    _syncService.synchronize(_device);
  }
}
