import 'package:domain/models/device.dart';
import 'package:infrastructure/interfaces/ilocal_network_service.dart';
import 'package:shared/page_view_model.dart';

class EstablishConnectionViewModel extends PageViewModel {
  late ILocalNetworkService _networkService;

  String _pairCode = "21345";
  String get pairCode => _pairCode;
  EstablishConnectionViewModel(super.context) {
    _networkService = getIt.get<ILocalNetworkService>();
  }

  late Device _device;

  ready() async {
    _device = router.getPageBindingData() as Device;
    var challanage = await _networkService.issueChallange(_device);
    // _networkService.connectToDevice(_device.ip, challange, signature)
  }

  onPairPressed() {}
}
