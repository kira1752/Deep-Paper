import 'package:state_notifier/state_notifier.dart';

import '../model/undo_model.dart';

class UndoStateProvider extends StateNotifier<UndoModel> with LocatorMixin {
  UndoStateProvider() : super(UndoModel(false, false));

  bool get canUndo => state.canUndo;

  bool get canRedo => state.canRedo;

  void toggleUndo() {
    state = UndoModel(!state.canUndo, state.canRedo);
  }

  void toggleRedo() {
    state = UndoModel(state.canUndo, !state.canRedo);
  }
}
