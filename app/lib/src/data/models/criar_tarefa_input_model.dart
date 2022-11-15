import 'package:todolist/src/data/models/item_tarefa_model.dart';
import 'package:todolist/src/domain/entities/criar_tarefa_input.dart';
import 'package:json_annotation/json_annotation.dart';

part 'criar_tarefa_input_model.g.dart';

@JsonSerializable()
class CriarTarefaInputModel extends CriarTarefaInput {
  final int idUsuario;
  final String tituloTarefa;
  final List<ItemTarefaModel> itens;

  CriarTarefaInputModel({
    required this.idUsuario,
    required this.tituloTarefa,
    required this.itens,
  }) : super(
          idUsuario: idUsuario,
          tituloTarefa: tituloTarefa,
          itens: itens,
        );

  factory CriarTarefaInputModel.fromJson(Map<String, dynamic> json) => _$CriarTarefaInputModelFromJson(json);

  final List itensJson = [];

  _buildObject() {
    for (var item in itens) {
      itensJson.add({
        "descricao": item.descricao,
        "concluido": item.concluido,
      });
    }
    return itensJson;
  }

  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "tituloTarefa": tituloTarefa,
        "itens": _buildObject(),
      };

  factory CriarTarefaInputModel.fromDomain(CriarTarefaInput domain) => CriarTarefaInputModel(
        idUsuario: domain.idUsuario,
        tituloTarefa: domain.tituloTarefa,
        itens: domain.itens.map((e) => ItemTarefaModel.fromDomain(e)).toList(),
      );
}
