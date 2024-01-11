import 'dart:io';

import 'package:presentation/page_view_model.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:domain/exceptions/no_camera_permission.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerViewmodel extends PageViewModel {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // late IAuthentication _authentication;
  // late IPageRouterService _router;

  bool _isFlashOn = false;
  bool _isCameraFront = false;
  IconData _iconFlashStatus = Icons.flash_on;

  IconData? get iconFlashStatus => _iconFlashStatus;
  IconData _iconCameraSatus = Icons.camera_rear;
  IconData? get iconCameraStatus => _iconCameraSatus;

  late BuildContext _context;
  late bool isDisposed;

  bool _scanResultEmpty = true;
  get scanResultEmpty => _scanResultEmpty;
  Function callback;
  QrScannerViewmodel(super.context, this.callback);

  initialisedModel(BuildContext context) {
    _context = context;
  }

  buildQrView(BuildContext context) {
    isDisposed = false;

    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: ((p0) => _onQRViewCreated(p0, context)),
      overlay: QrScannerOverlayShape(
        borderColor: ThemeStyles.theme.primary300,
        borderRadius: 5,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }

    controller.resumeCamera();
    notifyListeners();
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      _scanResultEmpty = false;
      notifyListeners();
      checkScanResult(result?.code, context);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      Future.delayed(Duration(seconds: 5), () {
        router.backToPrevious(context);
      });

      throw NoCameraPermissionException(context: context);
    }
  }

  void checkScanResult(String? result, BuildContext context) {
    callback.call(result);
  }

  toggleFlash() async {
    await controller?.toggleFlash();
    _isFlashOn = _isFlashOn == true ? false : true;
    if (_isFlashOn) {
      _iconFlashStatus = Icons.flash_off;
    } else {
      _iconFlashStatus = Icons.flash_on;
    }

    notifyListeners();
  }

  Future<bool?> getFlashStatus() async {
    return await controller?.getFlashStatus();
  }

  flipCamera() async {
    await controller?.flipCamera();
    notifyListeners();
  }

  Future<void> uploadFromGallery() async {
    // TODO extend the Qr_scanner to support image picking.
    // final file = await pickFile(
    //   allowedExtensions: ['zip'],
    //   allowedMimeTypes: ['image/jpeg', 'image/png'],
    // );
    // if (file != null) {
    //   List<String>? result =
    //       await _parent.controller?.scanQrcodeFromImage(file.path);
    //   // ignore: avoid_print
    //   print(result?.first);
    // }
    throw Exception("Not implemented");
  }

  toggleCamera() async {
    await controller?.flipCamera();
    _isCameraFront = _isCameraFront == false ? true : false;
    if (_isCameraFront) {
      _iconCameraSatus = Icons.camera_front;
    } else {
      _iconCameraSatus = Icons.camera_rear;
    }
    notifyListeners();
  }

  disposeModel() {
    controller?.stopCamera();
    controller?.dispose();
    router.callbackResult = null;
    isDisposed = true;
  }
}
