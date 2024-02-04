import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:shared/page_view_model.dart';
import 'package:domain/models/device.dart';

class ConnectDeviceScreenViewModel extends PageViewModel {
  ConnectDeviceScreenViewModel(super.context);

  List<Device> _devices = [
    Device("Workstation", "wda", "192.168.0.2", "21345", DeviceTypes.desktop,
        SyncTypes.full),
    Device("Workstation", "wda", "192.168.0.2", "21345", DeviceTypes.desktop,
        SyncTypes.partial),
    Device("Workstation", "wda", "192.168.0.2", "21345", DeviceTypes.desktop,
        SyncTypes.otc),
    Device("Workstation", "wda", "192.168.0.2", "21345", DeviceTypes.desktop,
        SyncTypes.otc),
  ];
  List<Device> get devices => _devices;

  onConnectNewDevice() {}

  ready() {
    _devices.first.isOnline = true;
    observer.getObserver("on_menu_state_changed", false);
  }

  onAddPressed() {}

  onDeviceSelected(Device device) {
    router.changePage(
      "/device",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
      bindingData: device,
    );
  }
}
