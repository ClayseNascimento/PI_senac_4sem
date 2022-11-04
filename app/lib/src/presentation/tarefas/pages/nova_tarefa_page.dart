import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
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
import 'package:todolist/src/presentation/tarefas/stores/nova_tarefa_store.dart';

class NovaTarefaPage extends StatefulWidget {
  const NovaTarefaPage({super.key});

  @override
  State<NovaTarefaPage> createState() => _NovaTarefaPageState();
}

class _NovaTarefaPageState extends ModularState<NovaTarefaPage, NovaTarefaStore> {
  @override
  void initState() {
    store.setNameTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        const Navbar(
          title: 'To do List',
          showBackButton: true,
        ),
        store.obx((tarefas) => Expanded(child: _buildBody()),
            onEmpty: const Center(child: Text('vazio')),
            onError: (error) => const Center(child: Text('erro')),
            onLoading: const Center(child: Text('load')))
      ],
    );
  }

  _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              store.nameTask,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: TodoColors.azul,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 24),
            BootstrapCol(
              sizes: ' col-md-4 col-12',
              child: Material(
                child: Visibility(
                  visible: store.nameTask == 'Criar tarefa',
                  child: ReactiveForm(
                    formGroup: store.form,
                    child: TextInput(
                      formControl: store.nameTaskControl,
                      hintText: 'Nova tarefa',
                      onSubmitted: () => store.saveTitleTask(),
                      validationMessages: const {
                        'required': 'Favor informar o título da tarefa',
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            BootstrapCol(
                sizes: 'col-md-3 col-6',
                child: ButtonAdd(
                  size: 50,
                  onTap: store.nameTask == 'Criar tarefa' ? () => store.saveTitleTask() : () => store.saveItensTask(),
                )),
            const SizedBox(height: 16),
            BootstrapCol(
              sizes: ' col-md-4 col-12',
              child: Visibility(
                visible: store.nameTask != 'Criar tarefa',
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: CheckboxTile(
                                          label: e,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Material(
                        child: ReactiveForm(
                          formGroup: store.form,
                          child: TextInput(
                            formControl: store.itemTaskControl,
                            hintText: 'Adicionar novo item',
                            onSubmitted: () => store.saveItensTask(),
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
          ],
        ),
        BootstrapCol(
            sizes: 'col-md-3 col-6',
            child: const Button(
              text: 'Salvar',
              // onPressed: () {},
            ).primario),
      ],
    );
  }
}
