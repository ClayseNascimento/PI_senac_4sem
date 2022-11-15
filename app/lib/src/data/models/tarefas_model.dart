// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:todolist/src/data/models/item_tarefa_model.dart';

import 'package:todolist/src/domain/entities/tarefas.dart';

part 'tarefas_model.g.dart';

@JsonSerializable()
class TarefasModel extends Tarefas {
  final int idTarefa;
  final String tituloTarefa;
  final List<ItemTarefaModel> itens;

  TarefasModel({
    required this.tituloTarefa,
    required this.idTarefa,
    required this.itens,
  }) : super(
          idTarefa: idTarefa,
          tituloTarefa: tituloTarefa,
          itens: itens,
        );

  factory TarefasModel.fromJson(Map<String, dynamic> json) => _$TarefasModelFromJson(json);
}
