import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:shared/page_view_model.dart';

class BiometricOptionViewModel extends PageViewModel {
  late IAuthorizationService _authorizationSerice;

  BiometricOptionViewModel(super.context) {
    _authorizationSerice = getIt.get<IAuthorizationService>();
  }

  onEnabled() async {
    //TODO check support for biometrics
    var enabled = await _authorizationSerice.enableBiometric();
    if (!enabled)
      throw BaseException(
        context: pageContext,
        message: "Device doesn't support biometrics.",
      );

    router.changePage(
      "/lock",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
    );
  }
}
