import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/orders_model.dart';
import 'package:flutter/services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<OrdersModel> orders = [];

  Future<void> loadOrders() async {
    emit(OrdersLoading());
    try {
      final jsonData = await rootBundle.loadString('assets/orders.json');

      orders = parseOrders(jsonData);

      emit(OrdersLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(error: e.toString()));
    }
  }

  double get totalOrders => orders.length.toDouble();

  double get averagePrice {
    if (orders.isEmpty) return 0;
    return orders.map((o) => o.price).reduce((a, b) => a + b) / orders.length;
  }

  int get returnsCount => orders.where((o) => o.status == 'RETURNED').length;

  Map<DateTime, int> getOrdersByDate() {
    var counter = 0;
    final Map<DateTime, int> ordersByDate = {};
    for (var order in orders) {
      final date = DateTime(
          order.registered.year, order.registered.month, order.registered.day);
      counter++;
      ordersByDate[date] = counter;
    }
    return ordersByDate;
  }

  List<DateTime> sortedDateList() {
    final ordersByDate = getOrdersByDate();
    return ordersByDate.keys.toList()..sort();
  }

  int currentIndex = 0;

  void navigateToDetails(int index) {
    currentIndex = index;
    emit(ChangePage(page: index));
  }
}
