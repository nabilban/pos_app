import 'package:intl/intl.dart';

class DateUtil {
  /// Formats a DateTime or String date to "dd/MM/yyyy HH:mm"
  static String formatFull(dynamic date) {
    if (date == null) return '-';
    
    DateTime? dt;
    if (date is DateTime) {
      dt = date;
    } else if (date is String) {
      dt = DateTime.tryParse(date);
    }
    
    if (dt == null) return '-';
    
    return DateFormat('dd/MM/yyyy  HH:mm').format(dt);
  }

  /// Formats a DateTime or String date to "dd/MM/yyyy"
  static String formatDateOnly(dynamic date) {
    if (date == null) return '-';
    
    DateTime? dt;
    if (date is DateTime) {
      dt = date;
    } else if (date is String) {
      dt = DateTime.tryParse(date);
    }
    
    if (dt == null) return '-';
    
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  /// Formats a DateTime or String date to "HH.mm"
  static String formatTimeOnly(dynamic date) {
    if (date == null) return '-';
    
    DateTime? dt;
    if (date is DateTime) {
      dt = date;
    } else if (date is String) {
      dt = DateTime.tryParse(date);
    }
    
    if (dt == null) return '-';
    
    return DateFormat('HH.mm').format(dt);
  }
}
