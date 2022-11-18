import 'package:equatable/equatable.dart';
import 'package:todolist/src/domain/entities/item_tarefa.dart';

// ignore: must_be_immutable
class CriarTarefaInput extends Equatable {
  final int idUsuario;
  final String tituloTarefa;
  List<ItemTarefa> itens;

  CriarTarefaInput({
    required this.idUsuario,
    required this.tituloTarefa,
    required this.itens,
  });

  @override
  List<Object> get props => [idUsuario, tituloTarefa, itens];

  @override
  bool? get stringify => true;
}
