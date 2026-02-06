import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yb_news/app/core/components/button/app_button.dart';
import 'package:yb_news/app/core/components/form/text_field/reactive_text_field.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/constants/app_assets.dart';
import 'package:yb_news/app/core/router/route_constants.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/extentions/space_extention.dart';
import 'package:yb_news/app/presentation/auth/register/controller/register_form_controller.dart';

class RegisterPage extends HookWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final form = buildRegisterForm();
    final obscure = useState(true);

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
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText(
                            'Signup to get Started',
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

                          ReactiveTextFieldX(
                            isRequired: true,
                            formControlName: 'passwordConfirmation',
                            label: 'Password Confirmation',
                            hint: 're-enter your password',
                            obscureText: obscure.value,
                            suffix: Icon(
                              size: 18,
                              obscure.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onSuffixTap: () => obscure.value = !obscure.value,
                            validationMessages: {
                              'required': (_) =>
                                  'Konfirmasi password wajib diisi',
                              'mustMatch': (_) => 'Password tidak cocok',
                            },
                          ),

                          24.h,
                          AppButton(label: 'Register', onPressed: () {}),
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
                              AppText('Already have an account ?'),
                              4.w,
                              InkWell(
                                onTap: () {
                                  context.go(RouteConstant.login);
                                },
                                child: AppText(
                                  'Login',
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
