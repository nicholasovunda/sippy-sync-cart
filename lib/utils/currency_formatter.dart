import 'package:intl/intl.dart';

NumberFormat currencyFormatter() {
  return NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 0);
}
