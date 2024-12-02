import 'package:flapkap_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chart_card.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = context.read<HomeCubit>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(
              'Orders over time',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            floating: true,
            snap: true,
          ),
          SliverPadding(
            padding: EdgeInsets.zero,
            sliver: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return const SliverToBoxAdapter(
                    child: ChartCard(
                      spots: [],
                      isLoading: true,
                    ),
                  );
                } else if (state is OrdersLoaded ||
                    homeCubit.orders.isNotEmpty) {
                  final spots = List.generate(
                    homeCubit.sortedDateList().length,
                    (index) {
                      return ChartData(
                        homeCubit.sortedDateList()[index],
                        homeCubit
                            .getOrdersByDate()[
                                homeCubit.sortedDateList()[index]]!
                            .toDouble(),
                      );
                    },
                  );

                  return SliverToBoxAdapter(
                    child: ChartCard(
                      spots: spots,
                    ),
                  );
                } else if (state is OrderError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${state.error}')),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('No data available')),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
