import '../../features/home/presentation/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}
