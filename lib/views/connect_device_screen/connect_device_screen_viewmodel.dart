import 'package:shared/page_view_model.dart';
import 'package:domain/models/device.dart';

class ConnectDeviceScreenViewModel extends PageViewModel {
  ConnectDeviceScreenViewModel(super.context);

  List<Device> _devices = [];
  List<Device> get devices => _devices;

  onConnectNewDevice() {}

  ready() {}
}
