import 'dart:async';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DebounceSearchResult {
  final String value;
  final FormControl<String> control;

  DebounceSearchResult({required this.value, required this.control});
}

DebounceSearchResult useDebounceSearch({int milliseconds = 500}) {
  final control = useMemoized(() => FormControl<String>());
  final searchText = useState<String>('');
  final timer = useRef<Timer?>(null);

  useEffect(() {
    final sub = control.valueChanges.listen((value) {
      timer.value?.cancel();

      timer.value = Timer(Duration(milliseconds: milliseconds), () {
        searchText.value = (value ?? '').trim();
      });
    });

    return () {
      sub.cancel();
      timer.value?.cancel();
    };
  }, [milliseconds]);

  return DebounceSearchResult(value: searchText.value, control: control);
}
