import 'dart:convert';

import 'package:domain/models/otp_code.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:otp/otp.dart';

class OtpService implements IOtpService {
  late IlocalStorage localStorage;
  OtpService(IlocalStorage storage) {
    localStorage = storage;
  }

  @override
  Future<OtpCode> add(OtpCode current) async {
    List<OtpCode> result = await getOtpData();

    result.add(current);
    await saveData(result);

    var code = OTP.generateTOTPCodeString(
      current.secret,
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
    var otpData = await localStorage.get("otp_data");
    if (otpData == null) return [];

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
