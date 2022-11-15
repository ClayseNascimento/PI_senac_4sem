// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criar_tarefa_input_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CriarTarefaInputModel _$CriarTarefaInputModelFromJson(
        Map<String, dynamic> json) =>
    CriarTarefaInputModel(
      idUsuario: json['idUsuario'] as int,
      tituloTarefa: json['tituloTarefa'] as String,
      itens: (json['itens'] as List<dynamic>)
          .map((e) => ItemTarefaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CriarTarefaInputModelToJson(
        CriarTarefaInputModel instance) =>
    <String, dynamic>{
      'idUsuario': instance.idUsuario,
      'tituloTarefa': instance.tituloTarefa,
      'itens': instance.itens,
    };
