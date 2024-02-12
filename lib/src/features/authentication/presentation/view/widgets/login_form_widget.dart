import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watt_charge_tracker/src/core/common/widgets/app_button.dart';
import 'package:watt_charge_tracker/src/core/common/widgets/app_loader.dart';
import 'package:watt_charge_tracker/src/core/common/widgets/app_textform_field.dart';
import 'package:watt_charge_tracker/src/core/constants/strings.dart';
import 'package:watt_charge_tracker/src/core/validators/form_validators.dart';
import 'package:watt_charge_tracker/src/features/authentication/presentation/controller/auth_controller.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _userNameController =
      TextEditingController(text: "bibychacko@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "Momentum@1");
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool showPassword = false;

  var authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextFormField(
                label: Strings.email,
                hint: Strings.emailHint,
                textEditingController: _userNameController,
                validator: (value) {
                  return FormValidators.isValidEmail(value);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              AppTextFormField(
                label: Strings.password,
                hint: "••••••••",
                textEditingController: _passwordController,
                isObscure: !showPassword,
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: showPassword
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                ),
                validator: (value) {
                  return FormValidators.isValidPassword(value);
                },
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                  onTap: _navigateToForgotPassword(),
                  child: const Text(Strings.forgotPassword)),
              const SizedBox(
                height: 24,
              ),
              Obx(() {
                if (authController.loginStatus.value == LoginState.loading) {
                  return const AppLoader();
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: AppButton(
                        buttonText: Strings.login,
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          if (!(_formKey.currentState?.validate() ?? false)) {
                            return;
                          }
                          _loginUser(context);
                        }),
                  );
                }
              })
            ],
          )),
    );
  }

  _loginUser(BuildContext context) {
    authController.login(
        _userNameController.text.trim(), _passwordController.text);
  }

  _navigateToForgotPassword() {
    //  TODO: Implement the functionality
  }
}
