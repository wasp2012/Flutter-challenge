import 'package:intl/intl.dart';

class OrderDateUtils {
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd').format(date);
  }

  static List<MapEntry<DateTime, int>> getOrdersByDate(List<dynamic> ordersJson) {
    final Map<DateTime, int> orderCounts = {};
    
    for (var order in ordersJson) {
      final date = DateFormat("yyyy-MM-dd'T'HH:mm:ss 'Z'").parse(order['registered']);
      final dateWithoutTime = DateTime(date.year, date.month, date.day);
      
      orderCounts[dateWithoutTime] = (orderCounts[dateWithoutTime] ?? 0) + 1;
    }

    var entries = orderCounts.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    
    return entries;
  }
}