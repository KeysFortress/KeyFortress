import 'package:domain/models/enums.dart';
import 'package:domain/models/stored_secret.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:presentation/components/identity_entry_box/identity_entry_box.dart';
import 'package:presentation/components/password_entry_box/password_entry_box.dart';
import 'package:infrastructure/interfaces/iidentity_manager.dart';
import 'package:presentation/page_view_model.dart';

class LandingPageViewModel extends PageViewModel {
  late ISecretManager _secretManger;
  late IIdentityManager _identityManager;
  List<StoredSecret> _secrets = [];
  List<StoredSecret> get secrets => _secrets;

  get identities => [];

  ActiveNavigationPage _activeNavigationPage = ActiveNavigationPage.passwords;
  get activePage => _activeNavigationPage;

  LandingPageViewModel(super.context) {
    _secretManger = getIt.get<ISecretManager>();
    _identityManager = getIt.get<IIdentityManager>();
    observer.subscribe("reload_passwords", onReload);
  }

  ready() async {
    await loadData();
    notifyListeners();
  }

  onReload() async {
    await loadData();
  }

  Future loadData() async {
    if (_activeNavigationPage == ActiveNavigationPage.passwords)
      _secrets = await _secretManger.getSecrets();
    if (_activeNavigationPage == ActiveNavigationPage.identities)
      notifyListeners();
  }

  onGenerateNewPassword() async {
    if (_activeNavigationPage == ActiveNavigationPage.passwords)
      generatePassword();
    if (_activeNavigationPage == ActiveNavigationPage.identities)
      await generateIdentity();
  }

  onPageChanged(ActiveNavigationPage page) {
    _activeNavigationPage = page;
    notifyListeners();
  }

  onSave() {
    router.dismissBar();
  }

  void generatePassword() {
    var password = _secretManger.generateSecret();
    print(password);
    router.openBar(
      PasswordEntryBox(
        password: password,
        onSave: onSave,
      ),
      pageContext,
    );
  }

  Future generateIdentity() async {
    var result = await _identityManager.generateIdentity();
    print(result.publicKey);
    print(result.privateKey);
    router.openBar(
      IdentityEntryBox(
        keyData: result,
        onSave: onSave,
      ),
      pageContext,
    );
  }
}
