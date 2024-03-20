import 'package:shared/page_view_model.dart';

class SyncSettingsViewModel extends PageViewModel {
  SyncSettingsViewModel(super.context);

  int _syncTime = 60;
  int get syncTime => _syncTime;

  onSubstractTime() {}

  onIncrementTime() {}
}
