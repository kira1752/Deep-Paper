import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useWidgetsBindingObserver(
    {@required Function(AppLifecycleState state) lifecycle}) {
  use(_Observer(lifecycle));
}

class _Observer extends Hook<void> {
  final Function(AppLifecycleState state) lifecycle;

  const _Observer(this.lifecycle);

  @override
  _ObserverState createState() => _ObserverState();
}

class _ObserverState extends HookState<void, _Observer>
    with WidgetsBindingObserver {
  @override
  void initHook() {
    super.initHook();
    // Watch Deep Paper app lifecycle when user creating new note
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    hook.lifecycle(state);
  }

  @override
  void dispose() {
    // Release the resource used by these observer and controller
    // when user exit Note Creation UI
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void build(BuildContext context) {}
}
