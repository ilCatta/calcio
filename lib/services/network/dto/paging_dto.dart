import 'package:equatable/equatable.dart';

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
