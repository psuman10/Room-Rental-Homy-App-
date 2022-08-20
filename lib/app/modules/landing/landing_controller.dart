import 'package:get/get.dart';
import 'package:homy_app/app/core/utils/enum.dart';
import 'package:homy_app/app/data/models/user.dart';
import 'package:homy_app/app/data/services/profile_service.dart';

class LandingController extends GetxController {
  final ProfileService _profileService = ProfileService();

  final selectedMenuItem = DrawwerMenuItemEnum.home.obs;
  final profile = UserModel().obs;
  void selectMenuItem(DrawwerMenuItemEnum menuItemEnum) {
    selectedMenuItem.value = menuItemEnum;
  }

  void getCurrentUserProfile() async {
    final profileResponse = await _profileService.getCurrentUserProfile();
    profileResponse.fold((fail) {}, (data) {
      profile.value = data;
    });
  }
}

class UserWithStatus {
  UserModel? user;
  CallStatus? status;

  UserWithStatus(this.status,this.user);
}

enum CallStatus { loading, success, fail }
