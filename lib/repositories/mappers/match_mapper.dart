/*
MAPPERS
All'interno dell'applicazione di sicuro non abbiamo necessità di mostrare tutte
le informazione all'interno di MatchDTO, perciò è ragionevole trasformare
un'istanza di tipo MatchDTO in un'istanza di tipio Match.
All'interno di un model, di una classe di tipo Match, mostreremo solo le informazioni
più importanti: quelle che vorremmmo far vedere

Perché non costruire un DTO che contiene solamente le informazioni che ci servono?
- semplificare
- generalizzare: accedere a delle particolari informazioni ad una schermata magari utilizzando
il model "match" e magari in un'altra schermata utilizzare sempre le stesse informazioni contenuti in "matchDTO" 
ma che devono essere rimappate in un altro oggetto diverso da "match"
- astrarre: nel caso cambi la sorgente dei dati

Avere un mapper che trasforma i dati all'occorrenza a partire da un insieme di informazioni più grande verso
un insieme di informazioni più piccolo ci semplifica la vita

object equality
If an object is equal to two others, then they must both be equal;
Se un oggetto è uguale ad altri due, allora devono essere entrambi uguali;
*/

import 'package:matches/misc/mapper.dart';
import 'package:matches/services/network/dto/match_dto.dart';
import 'package:matches/model/match.dart';

class MatchMapper extends DTOMapper<MatchDTO, Match> {
  @override
  Match toModel(MatchDTO dto) => Match(
        referee: dto.details.referee,
        dateTime: dto.details.date,
        stadium: dto.details.venue.name,
        elapsed: dto.details.status.elapsed,
        status: _mapMatchStatus(dto.details.status.short),
        league: League(
          name: dto.league.name,
          round: dto.league.round,
          imageUrl: dto.league.logo,
        ),
        teams: Teams(
          home: Team(
            name: dto.teams.home.name,
            logoUrl: dto.teams.home.logo,
            goals: dto.score.fulltime.home ?? dto.score.halftime.home ?? 0,
          ),
          away: Team(
            name: dto.teams.away.name,
            logoUrl: dto.teams.away.logo,
            goals: dto.score.fulltime.away ?? dto.score.halftime.away ?? 0,
          ),
        ),
      );

/*
Metodo che ci permette di mappare queste informazioni.
Dobbiamo trasformare di fatto una stringa verso un enum.
*/
  MatchStatus? _mapMatchStatus(String short) {
    switch (short) {
      case 'TBD':
        return MatchStatus.tbd;
      case 'NS':
        return MatchStatus.ns;
      case '1H':
        return MatchStatus.fh; // enum non può iniziare con un numero
      case 'HT':
        return MatchStatus.ht;
      case '2H':
        return MatchStatus.sh;
      case 'ET':
        return MatchStatus.et;
      case 'P':
        return MatchStatus.p;
      case 'FT':
        return MatchStatus.ft;
      case 'AET':
        return MatchStatus.aet;
      case 'PEN':
        return MatchStatus.pen;
      case 'BT':
        return MatchStatus.bt;
      case 'SUSP':
        return MatchStatus.susp;
      case 'INT':
        return MatchStatus.int;
      case 'PST':
        return MatchStatus.pst;
      case 'CANC':
        return MatchStatus.canc;
      case 'ABD':
        return MatchStatus.abd;
      case 'AWD':
        return MatchStatus.awd;
      case 'WO':
        return MatchStatus.wo;
      case 'LIVE':
        return MatchStatus.live;
    }

    return null;
  }

  @override
  MatchDTO toTransferObject(Match model) {
    // TODO: implement toTransferObject
    throw UnimplementedError();
  }
}
