// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:todolist/src/domain/entities/item_tarefa.dart';

class AlterarTarefaInput extends Equatable {
  final int idUsuario;
  final int idTarefa;
  final List<ItemTarefa> itens;

  AlterarTarefaInput({
    required this.idUsuario,
    required this.idTarefa,
    required this.itens,
  });

  @override
  List<Object> get props => [idTarefa];
}
