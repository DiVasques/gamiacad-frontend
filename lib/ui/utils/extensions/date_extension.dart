import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toLocalDateExtendedString() {
    DateFormat formatter = DateFormat.yMMMMd('pt_BR');
    return formatter.format(toLocal());
  }

  String toLocalTimeString() {
    DateFormat formatter = DateFormat.Hm();
    return formatter.format(toLocal());
  }
}
