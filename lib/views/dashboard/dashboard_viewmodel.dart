import 'package:domain/models/device.dart';
import 'package:shared/page_view_model.dart';

class DashboardViewModel extends PageViewModel {
  DashboardViewModel(super.context);

  List<Device> _connectedDevices = [];
  List<Device> get connectedDevices => _connectedDevices;
}
