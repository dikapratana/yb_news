import 'package:reactive_forms/reactive_forms.dart';

FormGroup buildResetPasswordForm() {
  return fb.group(
    {
      'password': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(8),
          Validators.pattern(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$'),
        ],
      ),
      'passwordConfirmation': FormControl<String>(
        validators: [Validators.required],
      ),
    },
    [Validators.mustMatch('password', 'passwordConfirmation')],
  );
}
