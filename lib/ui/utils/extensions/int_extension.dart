import 'package:intl/intl.dart';

extension IntExtension on int {
  String toStringDecimal() {
    NumberFormat formatter = NumberFormat.decimalPattern('pt_BR');
    return formatter.format(this);
  }

  String toStringLeadingZeroes() {
    NumberFormat formatter = NumberFormat('00000');
    return formatter.format(this);
  }
}
