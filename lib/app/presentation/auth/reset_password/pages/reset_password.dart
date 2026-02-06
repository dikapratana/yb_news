import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yb_news/app/core/components/button/app_button.dart';
import 'package:yb_news/app/core/components/form/text_field/reactive_text_field.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/router/route_constants.dart';
import 'package:yb_news/app/extentions/space_extention.dart';
import 'package:yb_news/app/presentation/auth/reset_password/controller/reset_password_controller.dart';

class ResetPasswordPage extends HookWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final form = buildResetPasswordForm();
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
                            'Reset \nPassword ?',
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                          ),
                          14.h,
                          // --- FIELD PASSWORD ---
                          ReactiveTextFieldX(
                            isRequired: true,
                            formControlName: 'password',
                            label: 'New Password',
                            hint: 'enter your new password',
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

                          // --- FIELD PASSWORD CONFIRMATION ---
                          ReactiveTextFieldX(
                            isRequired: true,
                            formControlName: 'passwordConfirmation',
                            label: 'Password New Confirmation',
                            hint: 're-enter your new confirmation',
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
                              'mustMatch': (_) =>
                                  'Password tidak cocok', // Key ini sangat penting!
                            },
                          ),

                          24.h,
                          AppButton(
                            label: 'Submit',
                            onPressed: () {
                              context.go(RouteConstant.login);
                            },
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
