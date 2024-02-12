import 'package:get/get.dart';
import 'package:watt_charge_tracker/src/core/helpers/location_helper.dart';
import 'package:watt_charge_tracker/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:watt_charge_tracker/src/features/tracker/presentation/controller/tracker_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrackerController());
    Get.lazyPut(() => AuthController());
    Get.put<LocationService>(LocationService(),permanent: true);
  }
}
