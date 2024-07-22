String formatDateTime(DateTime dateTime) {
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');

  return "$day/$month/$year    $hour:$minute";
}

String formatDate(DateTime dateTime) {
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();

  return "$day/$month/$year";
}

String convertToIsoFormat(String input) {
  try {
    final parts = input.split('/');
    if (parts.length != 3) throw const FormatException('Invalid date format');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    final dateTime = DateTime(year, month, day);
    return dateTime.toIso8601String();
  } catch (e) {
    throw const FormatException('Invalid date format');
  }
}
