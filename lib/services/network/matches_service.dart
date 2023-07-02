/*
Questo è un service che ci consentirà di eseguire le chiamate all'end point 
delle nostre API per ottenere i dati in formato JSON e modellarli nei nostri DTO
(che passeremo successivamente ai layer superiori)

*/

import 'dart:convert';
import 'dart:io';

import 'package:matches/errors/network_error.dart';
import 'package:matches/services/network/dto/match_dto.dart';
import 'package:http/http.dart' as http;
import 'package:matches/services/network/dto/matches_response.dart';

class MatchesService {
  static const _fixturesEndpoint = "fixtures"; //dato che l'endpoint sarà fisso possiamo definire una costante privata con l'endpoint di riferimento
  static const _xApiSportsKeyHeader = "x-apisports-key"; // headers parameters

  final String baseUrl;
  MatchesService(this.baseUrl);

/*
Il metodo Matches restituirà una lista di MatchDTO
In input avrà un parametro in formato stringa che ci serve a chiedere i matches di quella specifica giornata
*/
  Future<List<MatchDTO>> matches(String date) async {
    final response = await http.get(
      Uri.https(baseUrl, _fixturesEndpoint, {
        'date': date, // query parametri
      }),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        _xApiSportsKeyHeader: "cd5a6e561e14f180abc46710bda79540",
      },
    );

    // Dopo aver ottenuto la response dobbiamo verificare se la chiamata è andata a buon fine
    // Nel caso in cui lo status code vada fuori dal range 200 useremo la classe network error
    // Questo errore verrà eventualemnte intercettato dal layer superiore per rimbalzarlo e comunicarlo all'utente finale
    if (response.statusCode < 200 || response.statusCode > 299) {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }

    /* 
    Se tutto va bene dobbiamo trasformare il body in un oggetto map di string dynamic
    In sostanza dobbiamo fare la deserializzazione del json in qualcosa di più comprensibile
    che daremo in pasto al costruttore factory di matchesresponse per manipolare i nostri DTO
    */

    final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MatchesResponse.fromJson(decodedResponse).response;
  }
}
