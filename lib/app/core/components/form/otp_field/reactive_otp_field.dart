import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import '../../typography/app_text.dart';

class ReactiveOtpField extends StatelessWidget {
  final String formControlName;
  final int length;
  final Map<String, String Function(Object)>? validationMessages;

  const ReactiveOtpField({
    super.key,
    required this.formControlName,
    this.length = 4,
    this.validationMessages,
  });

  @override
  Widget build(BuildContext context) {
    // Gunakan ReactiveFormField (Tanpa kata 'Custom')
    return ReactiveFormField<String, String>(
      formControlName: formControlName,
      validationMessages: validationMessages,
      builder: (field) {
        final isInvalid = field.control.invalid && field.control.touched;

        final defaultPinTheme = PinTheme(
          width: 56,
          height: 56,
          textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.neutral1,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.neutral2),
          ),
        );

        return Column(
          children: [
            Pinput(
              length: length,
              // field.value mengambil nilai dari FormControl
              onChanged: (value) => field.didChange(value),
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: AppColors.error),
                ),
              ),
              // Pemicu warna merah pada kotak pinput
              forceErrorState: isInvalid,
            ),

            if (isInvalid) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 14,
                    color: AppColors.error,
                  ),
                  const SizedBox(width: 4),
                  AppText(
                    // field.errorText otomatis mengambil dari validationMessages
                    field.errorText ?? 'Invalid OTP',
                    color: AppColors.error,
                    fontSize: 12,
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
