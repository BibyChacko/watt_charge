
import 'package:intl/intl.dart';

class NumberFormatter{
  static String formatNumber(double number){
    NumberFormat numberFormatter = NumberFormat.compact();
    return numberFormatter.format(number);
  }
}