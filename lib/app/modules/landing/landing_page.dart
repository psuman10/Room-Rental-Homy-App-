import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/core/utils/enum.dart';
import 'package:homy_app/app/modules/home/home_page.dart';
import 'package:homy_app/app/modules/landing/landing_controller.dart';
import 'package:homy_app/app/modules/landing/widgets/landing_drawer.dart';
import 'package:homy_app/app/modules/my_bookings/my_bookings_page.dart';
import 'package:homy_app/app/modules/search/search_page.dart';
import 'package:homy_app/app/modules/wish_list/wish_list_page.dart';

import '../../data/database/homy_database.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await HomyDatabase.getHomePageProperties();
  }
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingController>(builder: (landingCtrl) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(const SearchPage());
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            )
          ],
        ),
        body: Obx(() {
          final _selectedMenuItem = landingCtrl.selectedMenuItem;
          switch (_selectedMenuItem.value) {
            case DrawwerMenuItemEnum.home:
              return const HomePage();

            case DrawwerMenuItemEnum.wishList:
              return const WishListPage();

            case DrawwerMenuItemEnum.myBookings:
              return const MyBookingsPage();

            default:
              return Container();
          }
        }),
        drawer: const LandingDrawer(),
      );
    });
  }
}
