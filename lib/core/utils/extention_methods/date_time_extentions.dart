import 'package:intl/intl.dart';

extension DateTimeExtentions on DateTime {
  String formatShortDate() {
    return DateFormat('yyyy/MM/dd').format(this);
  }
}
