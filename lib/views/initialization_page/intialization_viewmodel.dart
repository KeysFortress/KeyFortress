import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:shared/page_view_model.dart';

class InitializationViewModel extends PageViewModel {
  late IPageRouterService _pageRouterService;
  InitializationViewModel(super.context) {
    _pageRouterService = getIt.get<IPageRouterService>();
  }

  ready() {
    Future.delayed(Duration(milliseconds: 200), () {
      _pageRouterService.router.router.go("/lock");
    });
  }
}
