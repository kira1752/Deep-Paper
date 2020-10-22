class StringResource {
  StringResource._();

  // NOTE
  static const note = 'Note';
  static const all_notes = 'All Notes';
  static const delete = 'Delete';
  static const moveTo = 'Move to';
  static const restore = 'Restore';
  static const copy = 'Make a copy';
  static const trash = 'Trash';
  static const renameFolder = 'Rename Folder';
  static const deleteFolder = 'Delete Folder';
  static const emptyTrashBin = 'Empty Trash Bin';
  static const mainFolder = 'Main folder';
  static const trashEmptiedSuccessfully = 'Trash emptied successfully';
  static const restoreNoteDescription =
      'Restore this note to access all of its content.';
  static const deleteFolderDescription =
      'All notes inside this folder will be moved to trash.';
  static const tooltipSearch = 'Search button';
  static const tooltipFolderMenu = 'Open Folder Menu';
  static const tooltipSelectionMenu = 'Open Selection Menu';
  static const tooltipTrashMenu = 'Open Trash Bin menu';
  static const tooltipNoteHamburgerMenu = 'Open note menu';
  static const textDirectionLTR = 'TextDirection.ltr';
  static const textDirectionRTL = 'TextDirection.rtl';
  static const everyDays = 'Every days';

  static String selectionAppBar(int count) {
    return '$count selected';
  }

  static String titleAppBar(String title) {
    return '$title';
  }
}
