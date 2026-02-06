import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yb_news/app/core/components/button/app_button.dart';
import 'package:yb_news/app/core/components/checkbox/app_checkbox.dart';
import 'package:yb_news/app/core/components/form/text_field/reactive_text_field.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/constants/app_assets.dart';
import 'package:yb_news/app/core/router/route_constants.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/extentions/space_extention.dart';
import 'package:yb_news/app/presentation/auth/login/controller/login_form_controller.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final form = buildLoginForm();
    final obscure = useState(true);
    final rememberMe = useState(false);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ReactiveForm(
                      formGroup: form,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            'Hello',
                            fontSize: 48,
                            color: AppColors.neutral1,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText(
                            'Again',
                            fontSize: 48,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText(
                            'Welcome back you’ve \nbeen missed',
                            fontSize: 20,
                            color: AppColors.neutral2,
                            maxLines: 2,
                          ),
                          48.h,

                          ReactiveTextFieldX(
                            isRequired: true,
                            formControlName: 'email',
                            label: 'Email',
                            hint: 'enter your email',
                            clearable: true,
                            onSuffixTap: () {},
                            keyboardType: TextInputType.emailAddress,
                            validationMessages: {
                              'required': (_) => 'Email wajib diisi',
                              'email': (_) => 'Format email tidak valid',
                            },
                          ),
                          16.h,

                          // --- FIELD PASSWORD ---
                          ReactiveTextFieldX(
                            isRequired: true,
                            formControlName: 'password',
                            label: 'Password',
                            hint: 'enter your password',
                            obscureText: obscure.value,
                            suffix: Icon(
                              size: 18,
                              obscure.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onSuffixTap: () => obscure.value = !obscure.value,
                            validationMessages: {
                              'required': (_) => 'Password wajib diisi',
                              'minLength': (_) => 'Minimal 8 karakter',
                              'pattern': (_) =>
                                  'Harus kombinasi Huruf Besar, Kecil, dan Angka',
                            },
                          ),
                          16.h,
                          12.h,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppCheckbox(
                                value: rememberMe.value,
                                label: 'Remember me',
                                onChanged: (v) =>
                                    rememberMe.value = !rememberMe.value,
                              ),
                              InkWell(
                                onTap: () {
                                  context.push(RouteConstant.forgotPassword);
                                },
                                child: AppText(
                                  'Forgot Password ?',
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          24.h,
                          ReactiveFormConsumer(
                            builder: (context, form, child) {
                              return AppButton(
                                label: 'Login',
                                onPressed: () {
                                  context.go(RouteConstant.home);
                                },
                                disabled: !form.valid,
                              );
                            },
                          ),

                          16.h,
                          const Center(child: AppText('or continue with')),
                          16.h,
                          Center(
                            child: AppButton(
                              label: 'Google',
                              icon: Image.asset(AppIcon.google, height: 20),
                              onPressed: () {},
                              isFullWidth: false,
                              backgroundColor: AppColors.neutral3,
                              textColor: AppColors.neutral4,
                            ),
                          ),
                          16.h,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText('don’t have an account ?'),
                              4.w,
                              InkWell(
                                onTap: () {
                                  context.push(RouteConstant.register);
                                },
                                child: AppText(
                                  'Sign Up',
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
