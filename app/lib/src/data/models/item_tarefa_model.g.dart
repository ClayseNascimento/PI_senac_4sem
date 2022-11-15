// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_tarefa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemTarefaModel _$ItemTarefaModelFromJson(Map<String, dynamic> json) =>
    ItemTarefaModel(
      descricao: json['desc'] as String,
      concluido: json['concluido'] as bool,
      idItem: json['idItem'] as int?,
    );

Map<String, dynamic> _$ItemTarefaModelToJson(ItemTarefaModel instance) =>
    <String, dynamic>{
      'desc': instance.descricao,
      'concluido': instance.concluido,
      'idItem': instance.idItem,
    };
