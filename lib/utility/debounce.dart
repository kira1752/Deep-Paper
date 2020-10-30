import 'dart:async';

class Debounce {
  Timer _debounce;

  void run(Duration duration, Function onRun) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(duration, onRun);
  }

  void cancel() => _debounce?.cancel();
}
