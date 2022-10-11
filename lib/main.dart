import 'dart:io';

import 'package:currency_application/app/app.dart';
import 'package:currency_application/data/model/dbmodel/country_data.dart';
import 'package:currency_application/utils/app_bloc_observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<CountryData>(CountryDataAdapter());
  await Hive.initFlutter();
  await Hive.openBox('currency');
  await Hive.openBox('country');
  Bloc.observer = AppBlocObserver();
  runApp(const App());
}
