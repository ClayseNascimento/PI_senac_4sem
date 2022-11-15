import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ItemTarefa extends Equatable {
  final String descricao;
  bool concluido;
  final int? idItem;

  ItemTarefa({
    required this.descricao,
    required this.concluido,
    this.idItem,
  });

  @override
  List<Object> get props => [descricao, concluido];
}
