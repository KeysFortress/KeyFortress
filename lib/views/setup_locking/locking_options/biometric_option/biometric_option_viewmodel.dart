import 'package:domain/exceptions/base_exception.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:shared/page_view_model.dart';

class BiometricOptionViewModel extends PageViewModel {
  late IAuthorizationService _authorizationSerice;

  BiometricOptionViewModel(super.context) {
    _authorizationSerice = getIt.get<IAuthorizationService>();
  }

  onEnabled() async {
    var enabled = await _authorizationSerice.enableBiometric();
    if (!enabled)
      throw BaseException(
        context: pageContext,
        message: "Device doesn't support biometrics.",
      );

    router.router.router.go("/lock");
  }
}
