import 'package:jackpot/presenter/features/home/store/home_controller.dart';
import 'package:provider/provider.dart';

class Providers {
  static final providers = [
//////////////// HOME  //////////////////////////////
    ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
    ),
  ];
}
