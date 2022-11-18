import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todolist/src/@shared/bars/navbar.dart';
import 'package:todolist/src/@shared/buttons/button.dart';
import 'package:todolist/src/@shared/buttons/button_add.dart';
import 'package:todolist/src/@shared/buttons/checkbox_tile.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';
import 'package:todolist/src/@shared/inputs/text_input.dart';
import 'package:todolist/src/@shared/state/modular_state.dart';
import 'package:todolist/src/@shared/state/state_mixin.dart';
import 'package:todolist/src/domain/entities/tarefas.dart';
import 'package:todolist/src/presentation/tarefas/stores/editar_tarefa_store.dart';

class EditarTarefaPage extends StatefulWidget {
  static const editarTarefaArgs = 'editarTarefaArgs';
  final Tarefas tarefa;

  EditarTarefaPage({super.key, required this.tarefa});

  @override
  State<EditarTarefaPage> createState() => _EditarTarefaPageState();
}

class _EditarTarefaPageState extends TDModularState<EditarTarefaPage, EditarTarefaStore> {
  @override
  void initState()  {
    store.getItensTarefa(widget.tarefa.itens);
    store.setStateInitial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        store.setStateInitial();
      },
      child: Flex(
        direction: Axis.vertical,
        children: [
          const Navbar(
            title: 'To do List',
            showBackButton: true,
          ),
          store.obx((tarefas) => Expanded(child: _buildBody()),
              onEmpty: const Center(child: Text('vazio')),
              onError: (error) => const Center(child: Text('erro')),
              onLoading: _isLoading())
        ],
      ),
    );
  }

  _isLoading() {
    return const GFLoader(
      type: GFLoaderType.circle,
    );
  }

  _buildBody() {
    return GestureDetector(
      onTap: () {
        store.setStateInitial();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              // ---------- Titulo da tarefa -------
              Text(
                widget.tarefa.tituloTarefa,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: TodoColors.azul,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 24),
              // ---------- Botão para adicionar tarefa ou itens na tarefa ----------
              BootstrapCol(
                  sizes: 'col-md-3 col-6',
                  child: ButtonAdd(
                    size: 50,
                    onTap: () => store.addItensListItens(),
                  )),
              const SizedBox(height: 16),
              // ---------- itens adicionados na tarefa ----------
              BootstrapCol(
                sizes: ' col-md-6 col-12',
                child: Material(
                  color: TodoColors.transparent,
                  child: Visibility(
                    visible: store.listItens.isNotEmpty,
                    child: Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              Column(
                                children: (store.listItens)
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: CheckboxTile(
                                                  label: e.descricao,
                                                  value: e.idItem != null
                                                      ? e.concluido
                                                      : store.listItens[store.listItens.indexOf(e)].concluido,
                                                  onChanged: ((value) {
                                                    store.onChangeConcluido(value, e);
                                                  }),
                                                ),
                                              ),
                                              Visibility(
                                                visible: store.showOptionsItens &&
                                                    (store.indexItem == e.idItem ||
                                                        store.indexItem == store.listItens.indexOf(e)),
                                                child: InkWell(
                                                  onTap: () {
                                                    store.indexItem = store.listItens.indexOf(e);
                                                    store.editItemTask(context, e);
                                                  },
                                                  child: const Icon(
                                                    FontAwesomeIcons.pencil,
                                                    color: TodoColors.azul,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Visibility(
                                                visible: store.showOptionsItens &&
                                                    (store.indexItem == e.idItem ||
                                                        store.indexItem == store.listItens.indexOf(e)),
                                                child: InkWell(
                                                  onTap: () => store.deleteItemTask(context, e),
                                                  child: const Icon(
                                                    FontAwesomeIcons.trash,
                                                    color: TodoColors.vermelho,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: store.showEllipsis &&
                                                    (e.idItem != null
                                                        ? store.indexItem != e.idItem
                                                        : store.indexItem != store.listItens.indexOf(e)),
                                                child: InkWell(
                                                  onTap: (() {
                                                    store.showEditOrDelete(e);
                                                  }),
                                                  child: const Icon(
                                                    FontAwesomeIcons.ellipsisVertical,
                                                    color: TodoColors.preto,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          )),
                        ),
                        // ---------- Input de itens da tarefa ----------
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Material(
                            child: ReactiveForm(
                              formGroup: store.form,
                              child: TextInput(
                                onTap: (() => store.setStateInitial()),
                                formControl: store.itemTaskControl,
                                hintText: 'Adicionar novo item',
                                onSubmitted: () => store.addItensListItens(),
                                validationMessages: const {
                                  'required': 'Favor informar um item para essa tarefa',
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // ---------- botão para salvar alteração do card ----------
          BootstrapCol(
              sizes: 'col-md-3 col-6',
              child: Button(
                text: 'Salvar',
                onPressed: () => store.saveCardsTarefas(context, widget.tarefa.idTarefa),
              ).primario),
        ],
      ),
    );
  }
}
