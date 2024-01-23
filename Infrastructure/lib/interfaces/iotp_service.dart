import 'package:domain/models/otp_code.dart';

abstract class IOtpService {
  Future<List<OtpCode>> get();
  Future<OtpCode> add(String secret, String address);
  Future<bool> remove(String secret);
  String getCode(String secret);
}
