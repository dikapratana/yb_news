import 'package:reactive_forms/reactive_forms.dart';

FormGroup buildLoginForm() {
  return fb.group({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(8),
        Validators.pattern(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$'),
      ],
    ),
  });
}
