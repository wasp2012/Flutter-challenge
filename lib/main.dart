import 'package:flapkap_task/core/theme/app_theme.dart';
import 'package:flapkap_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:flapkap_task/features/home/presentation/pages/graph_screen.dart';
import 'package:flapkap_task/features/home/presentation/pages/metrics_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/dependancy_injection.dart';
import 'core/helpers/bloc_observer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await ScreenUtil.ensureScreenSize();
  await setupGetIt();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'FlapKap',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: BlocProvider(
          create: (context) => getIt<HomeCubit>()..loadOrders(),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Widget> _screens = [
    MetricsScreen(),
    GraphScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var homeCubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: _screens[homeCubit.currentIndex],
          bottomNavigationBar: NavigationBar(
            height: kIsWeb ? 100.h : null,
            backgroundColor: const Color(0xFF141428),
            selectedIndex: homeCubit.currentIndex,
            onDestinationSelected: (index) {
              homeCubit.navigateToDetails(index);
            },
            destinations: [
              NavigationDestination(
                icon:
                    Icon(Icons.analytics_outlined, size: kIsWeb ? 30.h : null),
                selectedIcon: Icon(Icons.analytics, size: kIsWeb ? 30.h : null),
                label: 'Metrics',
              ),
              NavigationDestination(
                icon:
                    Icon(Icons.show_chart_outlined, size: kIsWeb ? 30.h : null),
                selectedIcon:
                    Icon(Icons.show_chart, size: kIsWeb ? 30.h : null),
                label: 'Graph',
              ),
            ],
          ),
        );
      },
    );
  }
}
