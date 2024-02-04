import 'package:domain/models/device.dart';
import 'package:shared/page_view_model.dart';

class DeviceViewModel extends PageViewModel {
  String _deviceName = "";
  get deviceName => _deviceName;
  late Device _device;

  DeviceViewModel(super.context);

  ready() {
    _device = router.getPageBindingData() as Device;
    _deviceName = _device.name;
    notifyListeners();
  }
}
