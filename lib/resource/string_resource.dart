class StringResource {
  StringResource._();

  // NOTE
  static const note = 'Note';
  static const all_notes = 'All Notes';
  static const delete = 'Delete';
  static const deleteForever = 'Delete forever';
  static const moveTo = 'Move to';
  static const restore = 'Restore';
  static const copy = 'Make a copy';
  static const trash = 'Trash';
  static const rename = 'Rename';
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
  static const noRepeat = 'No repeat';
  static const days = 'days';
  static const weeks = 'weeks';
  static const months = 'months';
  static const years = 'years';
  static const daily = 'Daily';
  static const weekly = 'Weekly';
  static const monthly = 'Monthly';
  static const yearly = 'Yearly';
  static const chooseDate = 'Choose Date';
  static const chooseTime = 'Choose Time';

  static String selectionAppBar(int count) {
    return '$count selected';
  }

  static String titleAppBar(String title) {
    return '$title';
  }

  static String everyNDays(int n) {
    return 'Every $n days';
  }

  static String everyNWeeks(int n) {
    return 'Every $n weeks';
  }

  static String everyNMonths(int n) {
    return 'Every $n months';
  }

  static String everyNYears(int n) {
    return 'Every $n years';
  }
}
