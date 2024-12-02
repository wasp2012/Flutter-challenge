import 'package:flapkap_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../widgets/metric_card.dart';

class MetricsScreen extends StatelessWidget {
  const MetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    var homeCubit = context.read<HomeCubit>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(
              'Analytics Dashboard',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            floating: true,
            snap: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0.h),
            sliver: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kIsWeb ? 5 : 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildListDelegate(
                    [
                      MetricCard(
                        title: 'Total Orders',
                        value: homeCubit.totalOrders.toStringAsFixed(0),
                        icon: Icons.shopping_cart_outlined,
                        isLoading: state is OrdersLoading,
                      ),
                      MetricCard(
                        title: 'Average Order',
                        value: currencyFormat.format(homeCubit.averagePrice),
                        icon: Icons.payments_outlined,
                        iconColor: Colors.green.shade700,
                        isLoading: state is OrdersLoading,
                      ),
                      MetricCard(
                        title: 'Total returns',
                        value: homeCubit.returnsCount.toString(),
                        icon: Icons.assignment_return_outlined,
                        iconColor: Colors.orange.shade700,
                        isLoading: state is OrdersLoading,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
