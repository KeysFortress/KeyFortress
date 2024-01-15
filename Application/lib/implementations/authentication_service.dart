import 'dart:convert';

import 'package:infrastructure/interfaces/iauthentication_service.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:domain/models/http_request.dart';

class AuthenticationService implements IAuthenticationService {
  IHttpProviderService httpProvider;

  AuthenticationService(this.httpProvider);

  @override
  Future<String?> getChallenge(String url, String forUser, String publicKey,
      {String? bearer}) async {
    Map<String, String> headers =
        bearer != null ? {"Authorized": "Bearer $bearer"} : {};
    var httpResult = await httpProvider.postRequest(
      HttpRequest(
        url,
        headers,
        jsonEncode(
          {
            "PublicKey": publicKey,
            "ForUser": forUser,
          },
        ),
      ),
    );

    if (httpResult == null || httpResult.statusCode != 200) return null;

    return httpResult.body;
  }

  @override
  Future<bool> verifyChallange(String url, String signature,
      {String? bearer}) async {
    Map<String, String> headers =
        bearer != null ? {"Authorized": "Bearer $bearer"} : {};
    var httpResult = await httpProvider.postRequest(
      HttpRequest(
        url,
        headers,
        jsonEncode(
          {
            "Signature": signature,
          },
        ),
      ),
    );

    if (httpResult == null || httpResult.statusCode != 200) return false;

    return true;
  }
}
