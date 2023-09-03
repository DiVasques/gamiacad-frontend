import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/models/user.dart';
import 'package:gami_acad/repository/user_repository.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';
import 'package:gami_acad/ui/utils/view_state.dart';

class HomeController extends BaseController {
  late String userId;
  late UserRepository _userRepository;

  HomeController({required this.userId, UserRepository? userRepository}) {
    _userRepository = userRepository ?? UserRepository();
    getUser();
  }

  User get user => _userRepository.user;

  Future<void> getUser() async {
    setState(ViewState.busy);
    Result result = await _userRepository.getUser(id: userId);

    if (result.status) {
      setState(ViewState.idle);
    } else {
      setErrorMessage(result.message ?? '');
      setState(ViewState.error);
    }
  }
}
