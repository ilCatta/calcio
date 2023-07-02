/*
FetchMatchesEvent = scatena il download dei dati

*/

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:matches/repositories/matches_repository.dart';

final StoreMatchs = StoreMatchs().obs;

class StoreMatchs {
  List<Match> _match = [];

  Future<void> initialize(DateTime date) async {
    await GetIt.instance<MatchesRepository>().matches(date);
  }
}
