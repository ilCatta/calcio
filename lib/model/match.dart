import 'package:equatable/equatable.dart';

enum MatchStatus {
  tbd,
  ns,
  fh,
  ht,
  sh,
  et,
  p,
  ft,
  aet,
  pen,
  bt,
  susp,
  int,
  pst,
  canc,
  abd,
  awd,
  wo,
  live,
}

class Match extends Equatable {
  final String? referee; //arbitro
  final DateTime dateTime;
  final String? stadium;
  final MatchStatus? status;
  final int? elapsed; // tempo passato dall'inizio della partita
  final League league; // informazione composta
  final Teams teams;

  const Match({
    required this.referee,
    required this.dateTime,
    required this.stadium,
    required this.status,
    required this.elapsed,
    required this.league,
    required this.teams,
  });

  @override
  List<Object?> get props => [
        referee,
        dateTime,
        stadium,
        status,
        elapsed,
        league,
        teams,
      ];
}

class League extends Equatable {
  final String name;
  final String round;
  final String imageUrl;

  const League({
    required this.name,
    required this.round,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        name,
        round,
        imageUrl,
      ];
}

class Team extends Equatable {
  final String name;
  final String logoUrl;
  final int goals;

  const Team({
    required this.name,
    required this.logoUrl,
    required this.goals,
  });

  @override
  List<Object?> get props => [
        name,
        logoUrl,
        goals,
      ];
}

class Teams extends Equatable {
  final Team home;
  final Team away;

  const Teams({
    required this.home,
    required this.away,
  });

  @override
  List<Object?> get props => [
        home,
        away,
      ];
}
