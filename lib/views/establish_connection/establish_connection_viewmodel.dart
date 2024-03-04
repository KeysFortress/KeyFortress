import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/device.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/ilocal_network_service.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:shared/page_view_model.dart';

class EstablishConnectionViewModel extends PageViewModel {
  late ILocalNetworkService _networkService;
  late IPageRouterService _routerService;
  String _pairCode = "21345";
  String get pairCode => _pairCode;
  String _challange = "";
  EstablishConnectionViewModel(super.context) {
    _networkService = getIt.get<ILocalNetworkService>();
    _routerService = getIt.get<IPageRouterService>();
  }

  late Device _device;
  Device? get device => _device;

  ready() async {
    _device = router.getPageBindingData() as Device;
    _challange = await _networkService.requestChallange(_device);
  }

  onPairPressed() async {
    var result = await _networkService.connectToDevice(_device, _challange);

    if (!result)
      throw BaseException(
        context: pageContext,
        message: "Failed to pair with device or device already connected!",
      );

    _routerService.changePage(
      "/connect-devices",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
      slice: true,
      sliceCount: 2,
      saveRoute: false,
    );
  }

  String getDeviceImage() {
    switch (_device.deviceType) {
      case DeviceTypes.mobile:
        return "assets/images/mobile.svg";
      case DeviceTypes.desktop:
        return "assets/images/computer.svg";
      case DeviceTypes.tablet:
        return "assets/images/tablet.svg";
    }
  }
}
