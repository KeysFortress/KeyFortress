import 'package:domain/models/device.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/ilocal_network_service.dart';
import 'package:shared/page_view_model.dart';

class ConnectionListViewModel extends PageViewModel {
  late ILocalNetworkService _localNetworkService;

  List<Device> _devices = [];
  List<Device> get devices => _devices;

  ConnectionListViewModel(super.context) {
    _localNetworkService = getIt.get<ILocalNetworkService>();
  }

  ready() async {
    var currentScan = await _localNetworkService.scan();
    _devices = currentScan
        .where(
          (element) => element != null,
        )
        .map((e) => e!)
        .toList();
    print(_devices.length);
    notifyListeners();
  }

  onDeviceSelected(Device device) {
    router.changePage(
      "/establish-connection",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
      bindingData: device,
    );
  }

  onSearchChanged() {}

  String getDeviceType(int index) {
    var type = _devices.elementAt(index).deviceType;
    switch (type) {
      case DeviceTypes.mobile:
        return "assets/images/mobile.svg";
      case DeviceTypes.desktop:
        return "assets/images/computer.svg";
      case DeviceTypes.tablet:
        return "assets/images/tablet.svg";
    }
  }
}
