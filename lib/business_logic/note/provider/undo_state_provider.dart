import 'package:state_notifier/state_notifier.dart';

import '../model/undo_model.dart';

class UndoStateProvider extends StateNotifier<UndoModel> with LocatorMixin {
  UndoStateProvider() : super(UndoModel(canUndo: false, canRedo: false));

  bool get canUndo => state.canUndo;

  bool get canRedo => state.canRedo;

  void toggleUndo() {
    state = UndoModel(canUndo: !state.canUndo, canRedo: state.canRedo);
  }

  void toggleRedo() {
    state = UndoModel(canUndo: state.canUndo, canRedo: !state.canRedo);
  }
}
