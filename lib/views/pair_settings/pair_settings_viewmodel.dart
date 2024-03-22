import 'package:shared/page_view_model.dart';

class PairSettingsViewModel extends PageViewModel {
  PairSettingsViewModel(super.context);

  bool _pairEnabled = true;
  get pairEnabled => _pairEnabled;

  void onEnabledChanged(bool value) {}

  onPortNumberChanged(String number) {}

  onUpdateCertificate() {}
}
