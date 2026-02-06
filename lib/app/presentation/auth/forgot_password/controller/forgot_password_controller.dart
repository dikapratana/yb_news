import 'package:reactive_forms/reactive_forms.dart';

FormGroup buildForgotPasswordForm() {
  return fb.group({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
  });
}
