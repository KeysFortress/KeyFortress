import 'package:shared/page_view_model.dart';
import 'package:infrastructure/interfaces/iautofill_service.dart';

class AutoFillSettingViewModel extends PageViewModel {
  late IAutoFillService _autoFillService;
  AutoFillSettingViewModel(super.context) {
    _autoFillService = getIt.get<IAutoFillService>();
  }

  bool _autoFillEnabled = false;
  get autoFillEnabled => _autoFillEnabled;

  bool _passkeyAutoFill = false;
  get passkeyAutoFill => _passkeyAutoFill;

  ready() async {
    _autoFillEnabled = await _autoFillService.isAutoFillEnabled();
    _passkeyAutoFill = await _autoFillService.isPasskeyAutoFillEnabled();
  }

  void onAutoFillEnabled(bool value) async {
    _autoFillEnabled = value;
    await _autoFillService.enableAutoFill(value);
    notifyListeners();
  }

  void onPassKeyAutoFillEnabled(bool value) async {
    _passkeyAutoFill = value;
    await _autoFillService.enabledPasskeyAutoFill(value);
    notifyListeners();
  }
}
