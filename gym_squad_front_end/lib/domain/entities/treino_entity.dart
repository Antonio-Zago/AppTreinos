import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TreinoEntity extends Equatable{
  late int? id;
  final String nome;

  TreinoEntity({
    this.id,
    required this.nome
  });
  
  @override
  List<Object?> get props => [id];
}