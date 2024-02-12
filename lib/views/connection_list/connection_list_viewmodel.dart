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
    currentScan.forEach((element) {
      if (element != null) _devices.add(element);
    });
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
}
