import 'package:domain/models/cloud_connection_code.dart';
import 'package:infrastructure/interfaces/icloud_service.dart';
import 'package:shared/page_view_model.dart';

class MfaViewModel extends PageViewModel {
  late ICloudService _cloudService;
  late CloudConnectionCode _data;
  MfaViewModel(super.context) {
    _cloudService = getIt.get<ICloudService>();
  }

  ready() {
    _data = router.getPageBindingData() as CloudConnectionCode;
  }

  onMfaChanged(String code) {
    if (code.length < 6) return;

    _cloudService.performMethod(code, _data);
  }
}
