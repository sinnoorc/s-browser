import 'package:get/get.dart';

import 'screens/home_screen.dart';

class GetRoute {
  static List<GetPage<dynamic>>? getPage = [
    GetPage(
      name: '/',
      page: () => const HomeScreen(),
    ),
  ];
}
