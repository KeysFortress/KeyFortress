import 'package:domain/models/device.dart';
import 'package:infrastructure/interfaces/ilocal_network_service.dart';
import 'package:shared/page_view_model.dart';

class EstablishConnectionViewModel extends PageViewModel {
  late ILocalNetworkService _networkService;
  String _pairCode = "21345";
  String get pairCode => _pairCode;
  String _challange = "";
  EstablishConnectionViewModel(super.context) {
    _networkService = getIt.get<ILocalNetworkService>();
  }

  late Device _device;

  ready() async {
    _device = router.getPageBindingData() as Device;
    _challange = await _networkService.requestChallange(_device);
  }

  onPairPressed() {
    _networkService.connectToDevice(_device, _challange);
  }
}
