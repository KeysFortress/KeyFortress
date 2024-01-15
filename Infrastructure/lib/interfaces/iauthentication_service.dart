abstract class IAuthenticationService {
  Future<String?> getChallenge(String url, String forUser, String publicKey,
      {String? bearer});
  Future<bool> verifyChallange(String url, String signature, {String? bearer});
}
