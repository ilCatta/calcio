import 'package:equatable/equatable.dart';

class ParametersDTO extends Equatable {
  final String date;

  const ParametersDTO(this.date);

  factory ParametersDTO.fromJson(Map<String, dynamic> data) => ParametersDTO(data['date']);

  @override
  List<Object?> get props => [date];
}
