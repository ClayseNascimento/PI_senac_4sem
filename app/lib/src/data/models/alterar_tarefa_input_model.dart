import 'package:todolist/src/data/models/item_tarefa_model.dart';
import 'package:todolist/src/domain/entities/alterar_tarefa_input.dart';

class AlterarTarefaInputModel extends AlterarTarefaInput {
  final int idUsuario;
  final int idTarefa;
  final List<ItemTarefaModel> itens;

  AlterarTarefaInputModel({
    required this.idUsuario,
    required this.idTarefa,
    required this.itens,
  }) : super(
          idTarefa: idTarefa,
          idUsuario: idUsuario,
          itens: itens,
        );

  _buildObject() {
    final List itensJson = [];
    for (var item in itens) {
      itensJson.add({
        "descricao": item.descricao,
        "concluido": item.concluido,
        "idItem": item.idItem,
      });
    }
    return itensJson;
  }

  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "idTarefa": idTarefa,
        "itens": _buildObject(),
      };

  factory AlterarTarefaInputModel.fromDomain(AlterarTarefaInput domain) => AlterarTarefaInputModel(
        idUsuario: domain.idUsuario,
        idTarefa: domain.idTarefa,
        itens: domain.itens.map((e) => ItemTarefaModel.fromDomain(e)).toList(),
      );
}
