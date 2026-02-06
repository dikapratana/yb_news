import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/extentions/opacity_extention.dart';

import '../../../../extentions/empty_extention.dart';
import '../../typography/app_text.dart';

class ReactiveTextFieldX extends HookWidget {
  const ReactiveTextFieldX({
    super.key,
    this.formControlName,
    this.label = '',
    this.hint,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.prefix,
    this.suffix,
    this.onPrefixTap,
    this.onSuffixTap,
    this.validationMessages,
    this.formControl,
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.onChanged,
    this.isRequired = false,
    this.clearable = false,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 13,
      horizontal: 10,
    ),
  });

  final String? formControlName;
  final FormControl? formControl;

  final bool? isRequired;
  final String? label;
  final String? hint;
  final bool obscureText;
  final bool readOnly;
  final int maxLines;
  final TextAlign textAlign;
  final bool clearable;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onPrefixTap;
  final VoidCallback? onSuffixTap;
  final FocusNode? focusNode;
  final Function(FormControl)? onChanged;
  final EdgeInsets? contentPadding;

  final Map<String, String Function(Object)>? validationMessages;

  @override
  Widget build(BuildContext context) {
    final error = useState(false);
    final hasChanged = useState(false);
    final errorMessage = useState<String?>(null);
    final control = useState<FormControl?>(null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label!.isNotNullOrEmpty) ...[
          Row(
            children: [
              AppText(label!, color: AppColors.neutral2),
              if (isRequired!) ...[AppText('*', color: AppColors.error)],
            ],
          ),
          const SizedBox(height: 4),
        ],
        ReactiveTextField(
          formControlName: formControlName,
          focusNode: focusNode,
          formControl: formControl,
          obscureText: obscureText,
          readOnly: readOnly,
          maxLines: maxLines,
          minLines: maxLines == 1 ? 1 : null,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validationMessages: validationMessages,
          textAlign: textAlign,
          cursorColor: Theme.of(context).colorScheme.primary,
          cursorHeight: 20,
          onChanged: (formCtrl) {
            control.value = formCtrl;
            if (!hasChanged.value) {
              hasChanged.value = true;
              formCtrl.markAsTouched();
            }
            if (onChanged.isNotNullOrEmpty) {
              onChanged!(formCtrl);
            }
            error.value = formCtrl.invalid;

            if (formCtrl.invalid && validationMessages != null) {
              final firstErrorKey = formCtrl.errors.keys.first;
              final errorMsg = validationMessages![firstErrorKey];
              if (errorMsg != null) {
                errorMessage.value = errorMsg(formCtrl.errors[firstErrorKey]);
              } else {
                errorMessage.value = firstErrorKey;
              }
            } else {
              errorMessage.value = null;
            }
          },
          showErrors: (control) => hasChanged.value && control.invalid,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: contentPadding,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.black45),
            errorStyle: const TextStyle(fontSize: 0, height: 0),

            filled: error.value,
            fillColor: error.value
                ? AppColors.error.opacityx(0.1)
                : Colors.transparent,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.neutral2, width: 1),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: error.value ? AppColors.error : AppColors.neutral2,
                width: 1,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: error.value
                    ? AppColors.error
                    : Theme.of(context).colorScheme.primary,
                width: 1,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.error, width: 1),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.error, width: 1),
            ),

            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            prefixIcon: prefix == null
                ? null
                : _ActionWrapper(
                    onTap: onPrefixTap,
                    prefix: prefix.isNotNullOrEmpty,
                    child: IconTheme(
                      data: IconThemeData(
                        color: error.value
                            ? AppColors.error
                            : AppColors.neutral2,
                      ),
                      child: prefix!,
                    ),
                  ),
            suffixIcon: suffix == null && !error.value && !clearable
                ? null
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (clearable &&
                          (control.value?.value ?? '').toString().isNotEmpty)
                        _ActionWrapper(
                          onTap: () {
                            control.value?.reset();
                          },
                          suffix: true,
                          child: Icon(
                            Icons.clear_rounded,
                            color: error.value
                                ? AppColors.error
                                : AppColors.neutral2,
                            size: 18,
                          ),
                        ),
                      if (suffix != null)
                        _ActionWrapper(
                          onTap: onSuffixTap,
                          suffix: suffix.isNotNullOrEmpty,
                          child: IconTheme(
                            data: IconThemeData(
                              color: error.value
                                  ? AppColors.error
                                  : AppColors.neutral2,
                            ),
                            child: suffix!,
                          ),
                        ),
                    ],
                  ),
          ),
        ),

        if (error.value && errorMessage.value != null) ...[
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: AppColors.error),
              const SizedBox(width: 6),
              Expanded(
                child: AppText(
                  errorMessage.value ?? '',
                  color: AppColors.error,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _ActionWrapper extends StatelessWidget {
  const _ActionWrapper({
    required this.child,
    this.onTap,
    this.prefix = false,
    this.suffix = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool prefix;
  final bool suffix;

  @override
  Widget build(BuildContext context) {
    if (onTap == null) {
      return Container(
        margin: EdgeInsets.only(right: prefix ? 0 : 12, left: suffix ? 0 : 12),
        child: child,
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: child,
      ),
    );
  }
}
