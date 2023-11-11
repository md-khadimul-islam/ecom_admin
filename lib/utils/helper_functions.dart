import 'package:intl/intl.dart';

String getFormattedDate(DateTime dt, {String pattern = 'dd/MM/yyyy hh:mm:s a'}) =>
    DateFormat(pattern).format(dt);