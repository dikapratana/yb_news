import 'package:reactive_forms/reactive_forms.dart';

FormGroup buildOtpForm() {
  return fb.group({
    'otp_code': FormControl<String>(
      validators: [Validators.required, Validators.minLength(4)],
    ),
  });
}
