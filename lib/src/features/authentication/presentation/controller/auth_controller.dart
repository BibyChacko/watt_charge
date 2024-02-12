

import 'package:get/get.dart';
import 'package:watt_charge_tracker/src/core/constants/strings.dart';
import 'package:watt_charge_tracker/src/features/dashboard.dart';

enum LoginState { initial, loading, success, error }

class AuthController extends GetxController{

  var loginStatus = LoginState.initial.obs;

  login(String email,String password) {
    loginStatus.value = LoginState.loading;
    // TODO: Call API service
    bool status = true;
    loginStatus.value = status? LoginState.success : LoginState.error;
    if(!status) {
      Get.snackbar(Strings.authFailedTitle,Strings.authFailedMessage);
    }else{
      Get.to(const DashboardPage());
    }
  }

  logOut(){
    // TODO: Call API service
    loginStatus.value = LoginState.error;
  }

}