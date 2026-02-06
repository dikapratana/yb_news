import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yb_news/app/core/components/button/app_button.dart';
import 'package:yb_news/app/core/components/form/text_field/reactive_text_field.dart';
import 'package:yb_news/app/core/components/layout/main_layout.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/router/route_constants.dart';
import 'package:yb_news/app/extentions/space_extention.dart';
import 'package:yb_news/app/presentation/auth/forgot_password/controller/forgot_password_controller.dart';

class ForgotPasswordPage extends HookWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final form = buildForgotPasswordForm();
    void sendResetLink() {
      context.push(RouteConstant.otpVerification);
    }

    return ReactiveForm(
      formGroup: form,
      child: MainLayout(
        showBackButton: true,
        onBackPressed: () => context.pop(),
        bottomButton: ReactiveFormConsumer(
          builder: (context, form, child) {
            return AppButton(
              onPressed: sendResetLink,
              label: 'Submit',
              disabled: !form.valid,
            );
          },
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                'Forgot \nPassword ?',
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
              8.h,
              AppText(
                'Don’t worry! it happens. Please enter the address associated with your account.',
                fontSize: 14,
                maxLines: 2,
              ),
              16.h,
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
            ],
          ),
        ),
      ),
    );
  }
}
