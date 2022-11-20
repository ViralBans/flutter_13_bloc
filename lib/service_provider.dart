import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'service_provider.config.dart';

@InjectableInit()
void initializeServices() => $initGetIt(GetIt.I);