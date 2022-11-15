import 'package:todolist/src/domain/entities/item_tarefa.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_tarefa_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class ItemTarefaModel extends ItemTarefa {
  @JsonKey(name: 'desc')
  final String descricao;
  final bool concluido;
  final int? idItem;

  ItemTarefaModel({
    required this.descricao,
    required this.concluido,
    this.idItem,
  }) : super(
          descricao: descricao,
          concluido: concluido,
          idItem: idItem
        );

  factory ItemTarefaModel.fromJson(Map<String, dynamic> json) => _$ItemTarefaModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemTarefaModelToJson(this);

  factory ItemTarefaModel.fromDomain(ItemTarefa domain) => ItemTarefaModel(
        descricao: domain.descricao,
        concluido: domain.concluido,
        idItem: domain.idItem,
      );
}
