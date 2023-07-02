import 'package:matches/app.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:matches/repositories/mappers/match_mapper.dart';
import 'package:get_it/get_it.dart';
import 'package:matches/repositories/matches_repository.dart';
import 'package:matches/services/network/matches_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('it', null);

  // Iniettiamo tutti i layer all'interno della gerarchia dei widget:
  // Dependency injection
  GetIt.instance.registerSingleton<MatchMapper>(MatchMapper()); // layer mapper
  GetIt.instance.registerSingleton<MatchesService>(MatchesService("v3.football.api-sports.io")); // layer service/provider

  // layer repository
  GetIt.instance.registerSingleton<MatchesRepository>(MatchesRepository(
    matchMapper: GetIt.instance<MatchMapper>(),
    matchesService: GetIt.instance<MatchesService>(),
  ));

  runApp(const App());
}
