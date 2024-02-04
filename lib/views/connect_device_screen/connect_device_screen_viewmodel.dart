import 'package:domain/models/enums.dart';
import 'package:shared/page_view_model.dart';
import 'package:domain/models/device.dart';

class ConnectDeviceScreenViewModel extends PageViewModel {
  ConnectDeviceScreenViewModel(super.context);

  List<Device> _devices = [
    Device("Workstation", "wda", "192.168.0.2", "21345", DeviceTypes.desktop),
    Device("Workstation", "wda", "192.168.0.2", "21345", DeviceTypes.desktop),
    Device("Workstation", "wda", "192.168.0.2", "21345", DeviceTypes.desktop),
    Device("Workstation", "wda", "192.168.0.2", "21345", DeviceTypes.desktop),
  ];
  List<Device> get devices => _devices;

  onConnectNewDevice() {}

  ready() {
    _devices.first.isOnline = true;
    observer.getObserver("on_menu_state_changed", false);
  }

  onAddPressed() {}
}
