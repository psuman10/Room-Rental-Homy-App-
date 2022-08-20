import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/core/utils/enum.dart';
import 'package:homy_app/app/core/values/colors.dart';
import 'package:homy_app/app/core/values/constants.dart';
import 'package:homy_app/app/data/database/homy_database.dart';
import 'package:homy_app/app/data/models/user.dart';
import 'package:homy_app/app/modules/about/about_page.dart';
import 'package:homy_app/app/modules/auth/auth_controller.dart';
import 'package:homy_app/app/modules/landing/landing_controller.dart';
import 'package:homy_app/app/modules/profile_edit/profile_edit_page.dart';
import 'package:homy_app/app/modules/settings/settings_page.dart';
import 'package:share_plus/share_plus.dart';

class LandingDrawer extends StatefulWidget {
  const LandingDrawer({Key? key}) : super(key: key);

  @override
  State<LandingDrawer> createState() => _LandingDrawerState();
}

class _LandingDrawerState extends State<LandingDrawer> {
  @override
  void initState() {
    Get.put(AuthController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    return GetBuilder<LandingController>(builder: (_landingCtrl) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        color: white,
        child: ListView(
          children: [
            FutureBuilder<UserModel>(
                future: HomyDatabase.getCurrentProfile(
                    userId: FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null && snapshot.hasData) {
                      final UserModel _user = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryBlue),
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: _user.profileURL != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              _user.profileURL!,
                                            ))
                                        : const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              "assets/images/user.png",
                                            ),
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    _user.fullName ?? "",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(_user.email ?? ""),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Get.to(
                                      ProfileEditPage(
                                        user: _user,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Edit",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                  } else {
                    return Container();
                  }
                }),
            Column(
              children: [
                const Divider(thickness: 1.0),
                _drawerMenuItem(
                  title: "Home",
                  icon: Icons.home,
                  onTap: () {
                    _landingCtrl.selectMenuItem(DrawwerMenuItemEnum.home);
                    Navigator.pop(context);
                  },
                  isSelected: _landingCtrl.selectedMenuItem.value ==
                      DrawwerMenuItemEnum.home,
                ),
                _drawerMenuItem(
                  title: "Wish List",
                  icon: Icons.bookmark,
                  onTap: () {
                    _landingCtrl.selectMenuItem(DrawwerMenuItemEnum.wishList);
                    Navigator.pop(context);
                  },
                  isSelected: _landingCtrl.selectedMenuItem.value ==
                      DrawwerMenuItemEnum.wishList,
                ),
                _drawerMenuItem(
                    title: "My Bookings",
                    icon: Icons.event_note,
                    isSelected: _landingCtrl.selectedMenuItem.value ==
                        DrawwerMenuItemEnum.myBookings,
                    onTap: () {
                      _landingCtrl
                          .selectMenuItem(DrawwerMenuItemEnum.myBookings);
                      Navigator.pop(context);
                    }),
                const Divider(thickness: 1.0),
                _drawerMenuItem(
                    title: "About",
                    icon: Icons.info,
                    isSelected: _landingCtrl.selectedMenuItem.value ==
                        DrawwerMenuItemEnum.about,
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(const AboutPage());
                    }),
                _drawerMenuItem(
                    title: "Settings",
                    icon: Icons.settings,
                    isSelected: _landingCtrl.selectedMenuItem.value ==
                        DrawwerMenuItemEnum.setting,
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(const SettingsPage());
                    }),
                // _drawerMenuItem(
                //   title: "Privacy Policy",
                //   icon: Icons.policy,
                //   isSelected: _landingCtrl.selectedMenuItem.value ==
                //       DrawwerMenuItemEnum.privacy,
                // ),
                _drawerMenuItem(
                    title: "Share Via",
                    icon: Icons.share,
                    isSelected: _landingCtrl.selectedMenuItem.value ==
                        DrawwerMenuItemEnum.share,
                    onTap: () {
                      Share.share(AppConstants.appLink);
                    }),
                _drawerMenuItem(
                  title: "Logout",
                  icon: Icons.logout,
                  onTap: () {
                    authCtrl.logout();
                  },
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget _drawerMenuItem({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: isSelected ? primaryBlue.withOpacity(0.1) : white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        horizontalTitleGap: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        minVerticalPadding: 0,
        dense: true,
        onTap: onTap,
        leading: Icon(
          icon,
          color: primaryDark,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
