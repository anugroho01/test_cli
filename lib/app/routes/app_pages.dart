import 'package:get/get.dart';

import '../modules/change_profile/bindings/change_profile_binding.dart';
import '../modules/change_profile/views/change_profile_view.dart';
import '../modules/chatroom/bindings/chatroom_binding.dart';
import '../modules/chatroom/views/chatroom_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intoduction/bindings/intoduction_binding.dart';
import '../modules/intoduction/views/intoduction_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/searchpage/bindings/searchpage_binding.dart';
import '../modules/searchpage/views/searchpage_view.dart';
import '../modules/update_status/bindings/update_status_binding.dart';
import '../modules/update_status/views/update_status_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  //static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTODUCTION,
      page: () => const IntoductionView(),
      binding: IntoductionBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHATROOM,
      page: () => const ChatroomView(),
      binding: ChatroomBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHPAGE,
      page: () => SearchpageView(),
      binding: SearchpageBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_STATUS,
      page: () => const UpdateStatusView(),
      binding: UpdateStatusBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PROFILE,
      page: () => const ChangeProfileView(),
      binding: ChangeProfileBinding(),
    ),
  ];
}
