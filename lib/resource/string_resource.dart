class StringResource {
  StringResource._();

  // NOTE
  static const note = 'NOTE';
  static const delete = 'Delete';
  static const moveTo = 'Move to';
  static const restore = 'Restore';
  static const copy = 'Make a copy';
  static const renameFolder = 'Rename Folder';
  static const deleteFolder = 'Delete Folder';
  static const emptyTrashBin = 'Empty Trash Bin';
  static const trashEmptiedSuccessfully = 'Trash emptied successfully';
  static const tooltipSearch = 'Search button';
  static const tooltipFolderMenu = 'Open Folder Menu';
  static const tooltipSelectionMenu = 'Open Selection Menu';
  static const tooltipTrashMenu = 'Open Trash Bin menu';
  static const tooltipNoteHamburgerMenu = 'Open note menu';

  static String selectionAppBar(int count) {
    return '$count selected';
  }

  static String titleAppBar(String title) {
    return '$title';
  }
}
