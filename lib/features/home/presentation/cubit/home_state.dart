part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}
class ChangePage extends HomeState {
  final int page;
  const ChangePage({required this.page});
  @override
  List<Object> get props => [page];
}

class HomeInitial extends HomeState {}

class OrdersLoading extends HomeState {}

class OrdersLoaded extends HomeState {
  final List<OrdersModel> orders;
  const OrdersLoaded({required this.orders});
  @override
  List<Object> get props => [orders];
}

class OrderError extends HomeState {
  final String error;
  const OrderError({required this.error});
  @override
  List<Object> get props => [error];
}

