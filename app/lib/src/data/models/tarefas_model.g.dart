// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefas_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TarefasModel _$TarefasModelFromJson(Map<String, dynamic> json) => TarefasModel(
      tituloTarefa: json['tituloTarefa'] as String,
      idTarefa: json['idTarefa'] as int,
      itens: (json['itens'] as List<dynamic>)
          .map((e) => ItemTarefaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TarefasModelToJson(TarefasModel instance) =>
    <String, dynamic>{
      'idTarefa': instance.idTarefa,
      'tituloTarefa': instance.tituloTarefa,
      'itens': instance.itens,
    };
