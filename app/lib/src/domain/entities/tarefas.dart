// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:equatable/equatable.dart';

import 'package:todolist/src/domain/entities/item_tarefa.dart';

class Tarefas {
  final int idTarefa;
  final String tituloTarefa;
  final List<ItemTarefa> itens;

  Tarefas({
    required this.tituloTarefa,
    required this.idTarefa,
    required this.itens,
  });

  // // @override
  // List<Object> get props => [tituloTarefa];
}
