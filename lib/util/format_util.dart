import 'package:intl/intl.dart';

class FormatUtil {
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('MMMM d');
    return formatter.format(date);
  }

  static String formatCurrency(double value) {
    final formatter = NumberFormat.currency(locale: 'es_CO', symbol: '', decimalDigits: 0);
    return formatter.format(value);
  }
}
