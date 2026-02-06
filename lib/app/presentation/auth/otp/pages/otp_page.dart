import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yb_news/app/core/components/button/app_button.dart';
import 'package:yb_news/app/core/components/form/otp_field/reactive_otp_field.dart';
import 'package:yb_news/app/core/components/layout/main_layout.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/router/route_constants.dart';
import 'package:yb_news/app/extentions/space_extention.dart';
import 'package:yb_news/app/presentation/auth/otp/controller/otp_controller.dart';

class OtpPage extends HookWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final form = buildOtpForm();
    void sendResetLink() {
      context.push(RouteConstant.resetPassword);
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
              label: 'Verify',
              disabled: !form.valid,
            );
          },
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                'OTP Verification',
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
              8.h,
              AppText(
                'Enter the OTP sent to email@gmail.com',
                fontSize: 14,
                maxLines: 2,
              ),
              16.h,
              Column(
                children: [
                  ReactiveOtpField(
                    formControlName: 'otp_code',
                    length: 4,
                    validationMessages: {
                      'required': (error) => 'OTP tidak boleh kosong',
                      'minLength': (error) => 'Harap isi semua digit',
                    },
                  ),

                  48.h,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
