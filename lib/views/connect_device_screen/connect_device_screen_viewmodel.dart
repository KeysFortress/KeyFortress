import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:shared/page_view_model.dart';
import 'package:domain/models/device.dart';

class ConnectDeviceScreenViewModel extends PageViewModel {
  ConnectDeviceScreenViewModel(super.context);

  List<Device> _devices = [];
  List<Device> get devices => _devices;

  onConnectNewDevice() {}

  ready() {
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

  onAddConnection() {
    router.changePage(
      "/connection-list",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }
}
