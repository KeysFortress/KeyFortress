class StoredIdentity {
  String name;
  String publicKey;
  String privateKey;

  StoredIdentity(this.name, this.privateKey, this.publicKey);

  factory StoredIdentity.fromJson(Map<String, dynamic> json) {
    return StoredIdentity(
      json['name'] as String,
      json['privateKey'] as String,
      json['publicKey'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'privateKey': privateKey,
      'publicKey': publicKey,
    };
  }
}
