import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myshop/ui/common/app_colors.dart';
import 'package:myshop/ui/common/app_text_styles.dart';
import 'package:myshop/ui/common/custom_text_field.dart';
import 'package:myshop/ui/common/primary_button.dart';
import 'package:myshop/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Text("Welcome\nBack!", style: AppTextStyle.heading),

              const SizedBox(height: 40),

              CustomTextField(
                controller: viewModel.emailController,
                hintText: "Email",
                prefixIcon: Icons.person,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: viewModel.passwordController,
                hintText: "Password",
                prefixIcon: Icons.lock,
                obscureText: viewModel.obscurePassword,
                textInputAction: TextInputAction.done,
                suffixIcon: IconButton(
                  icon: Icon(
                    viewModel.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: viewModel.togglePassword,
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: AppColors.primary, fontSize: 13),
                ),
              ),

              const SizedBox(height: 40),

              PrimaryButton(
                title: "Login",
                isLoading: viewModel.isBusy,
                onPressed: viewModel.login,
              ),

              const SizedBox(height: 40),

              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                    children: [
                      const TextSpan(text: "Create An Account "),
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            viewModel.goToSignup();
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) {
    return LoginViewModel();
  }
}
