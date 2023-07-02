/*
DTO - DATA TRANSFER OBJECTS
Particolari classi che vengono utilizzate a livello di business per veicolare le
informazioni da un layer al altro.
Sono simili ai "model" e alle "entitys" ma servono di fatto per garantire il
trasporto da un layer al altro.
Nel nostro caso useremo i DTO nel layer delle api (layer network).
Nel momento in cui faremo salire le informazioni ad un layer superiore (verosimilemnte
quello di repository) queste istante di tipo DTO cambieranno e si concretizzeranno
in dei model.
Questa particolare operazione verrà eseguita dai mapper.

I nostri dto sono anche dei POJO: PLAIN OLD JSON OBJECTS 
Ovvero un Json che andremo a svuotare all'interno di una o più classi. 


MACHES RESPONSE
Conterrà la risposta dell'API 
*/

import 'package:equatable/equatable.dart';
import 'package:matches/services/network/dto/match_dto.dart';

class MatchesResponse extends Equatable {
  final String get;
  final ParametersDTO parameters;
  final Map<String, String>? errors;
  final int results;
  final PagingDTO paging;
  final List<MatchDTO> response;

  const MatchesResponse({
    required this.get,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.response,
  });

/* FACTORY
Il custruttore factory esegue il parse da Json e costruisce un'istanza di MatchesResponse
*/

  factory MatchesResponse.fromJson(Map<String, dynamic> data) => MatchesResponse(
        get: data['get'],
        parameters: ParametersDTO.fromJson(data['parameters']), // oggetto innestato quindi usiamo il fromJson di ParametersDTO
        errors: data.containsKey('errors') ? data['errors'] : null, // dato che questo elemento è nullable dobbiamo verificare se è presente
        results: data['results'],
        paging: PagingDTO.fromJson(data['paging']),
        response: (data['response'] as List).map((item) => MatchDTO.fromJson(item as Map<String, dynamic>)).toList(growable: false),
      );

  /*resposne: si tratta di una lista quindi applichiamo un comportamento differente.
      Intanto castiamo la response contenuta dentro "data" in una lista.
      Dopodichè facciamo un map invocando MatchDTO.fromJson cosicchè ogni singolo elemento verrà rimappato costruendo MatchDTO
      "item" è di tipo dynamic quindi dobbiamo castarlo a  Map<String, dynamic>
      */

  @override
  List<Object?> get props => [
        get,
        parameters,
        errors,
        results,
        paging,
        response,
      ];

  /*
  override di props
  In modo da discriminare quando una istanza di tipo MatchesResponse differisce da un'altra
  */
}

class PagingDTO extends Equatable {
  final int current;
  final int total;

  const PagingDTO(this.current, this.total);

  factory PagingDTO.fromJson(Map<String, dynamic> data) => PagingDTO(
        data['current'],
        data['total'],
      );

  @override
  List<Object?> get props => [current, total];
}

class ParametersDTO extends Equatable {
  final String date;

  const ParametersDTO(this.date);

  factory ParametersDTO.fromJson(Map<String, dynamic> data) => ParametersDTO(data['date']);

  @override
  List<Object?> get props => [date];
}
