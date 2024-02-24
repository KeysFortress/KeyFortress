import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/idevices_service.dart';
import 'package:shared/page_view_model.dart';
import 'package:domain/models/device.dart';

class ConnectDeviceScreenViewModel extends PageViewModel {
  late IDevicesService _devicesService;
  List<Device> _devices = [];
  List<Device> get devices => _devices;

  ConnectDeviceScreenViewModel(super.context) {
    _devicesService = getIt.get<IDevicesService>();
  }

  ready() async {
    _devices = await _devicesService.all();
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

  onConnectNewDevice() {}
}
