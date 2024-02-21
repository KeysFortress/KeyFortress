import 'package:domain/models/device.dart';
import 'package:shared/page_view_model.dart';

class EstablishConnectionViewModel extends PageViewModel {
  String _pairCode = "21345";
  String get pairCode => _pairCode;
  EstablishConnectionViewModel(super.context);
  late Device _device;

  ready() {
    _device = router.getPageBindingData() as Device;
  }

  onPairPressed() {}
}
