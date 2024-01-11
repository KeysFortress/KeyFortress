import 'package:domain/exceptions/base_exception.dart';

class NoCameraPermissionException extends BaseException {
  NoCameraPermissionException({required super.context});

  @override
  String? message = "Camera permission denied";

  @override
  String? title =
      "Please go to your device settings and enable the camera permissions for this application.";
}
