import 'dart:convert';

import 'package:domain/models/otp_code.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:otp/otp.dart';

class OtpService implements IOtpService {
  IlocalStorage localStorage;
  OtpService(this.localStorage);

  @override
  Future<OtpCode> add(String secret, String address) async {
    List<OtpCode> result = await getOtpData();
    var current = OtpCode("", address, secret);
    result.add(current);
    await saveData(result);
    var code = OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
    );
    current.code = code;
    return current;
  }

  @override
  Future<List<OtpCode>> get() async {
    return getOtpData();
  }

  @override
  Future<bool> remove(String secret) async {
    List<OtpCode> result = await getOtpData();
    result.removeWhere((element) => element.matchSecret(secret));
    return await saveData(result);
  }

  @override
  String getCode(String secret) {
    return OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<List<OtpCode>> getOtpData() async {
    var otpData = await localStorage.get("secrets");
    if (otpData == null) otpData = [];

    List<dynamic> data = jsonDecode(otpData);
    List<OtpCode> result = [];
    data.forEach((element) {
      var current = OtpCode.fromJson(element);
      result.add(current);
    });

    return result;
  }

  Future<bool> saveData(List<OtpCode> result) async {
    var json = result.map((e) => e.toJson()).toList();
    var jsonData = jsonEncode(json);
    await localStorage.set("otp_data", jsonData);
    return true;
  }
}
