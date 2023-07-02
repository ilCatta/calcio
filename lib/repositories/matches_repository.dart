import 'package:intl/intl.dart';
import 'package:matches/errors/network_error.dart';
import 'package:matches/errors/repository_error.dart';
import 'package:matches/repositories/mappers/match_mapper.dart';
import 'package:matches/services/network/matches_service.dart';
import 'package:matches/model/match.dart';

/*
IL REPOSITORY è un pattern che consente di disaccoppiare l'accesso al layer dei dati (nel nostro caso rappresentato
dal layer dei provider/service) rispetto all layer di presentation (ovvero quello relativo alle interfaccie grafiche).

Dato che questo repository non dovrà accedere a più sorgenti dati, 
l'unico metodo che definiamo sarà quello di "matches" il quale andrà di fatto
ad invocare il layer sottostante ovvero quello di matches service che interrogherà le API.

*/

class MatchesRepository {
  final MatchesService matchesService;
  final MatchMapper matchMapper;

  MatchesRepository({
    required this.matchesService,
    required this.matchMapper,
  });

  Future<List<Match>> matches(DateTime date) async {
    /*
      GESTIONE ERRORI
    A questo livello se c'è un errore è di tipo repository.
    In particolare qui possiamo avere 2 tipologie di errore:
    - errori di tipo network error che rilanciamo da matchesService
    - errori più generici, ovvero tutti quelli che NON fanno parte della casistica repositoryError

    */

    try {
      final response = await matchesService.matches(DateFormat("yyyy-MM-dd").format(date));
      return response.map(matchMapper.toModel).toList(growable: false);
    } on NetworkError catch (e) {
      // Caso di errore network
      throw RepositoryError(e.reasonPhrase);
    } catch (e) {
      // Tutti gli altri casi di errore invoca un repositoryError generico
      throw RepositoryError();
    }
  }
}
