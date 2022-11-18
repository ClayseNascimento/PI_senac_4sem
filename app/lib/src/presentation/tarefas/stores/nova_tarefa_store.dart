import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todolist/src/@shared/alerts/todo_dialog.dart';
import 'package:todolist/src/@shared/inputs/text_input.dart';
import 'package:todolist/src/@shared/state/stores.dart';
import 'package:todolist/src/domain/entities/criar_tarefa_input.dart';
import 'package:todolist/src/domain/entities/item_tarefa.dart';
import 'package:todolist/src/domain/usecases/criar_tarefa_usecase.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:todolist/src/presentation/home/home_module.dart';

class NovaTarefaStore extends TDStore<CriarTarefaInput> {
  final CriarTarefaUsecase _criarTarefaUsecase;

  NovaTarefaStore(this._criarTarefaUsecase);

  // -------------- Controller input--------------------
  final FormGroup form = FormGroup({
    NovaTarefaFormFields.task: FormControl<String>(validators: [
      Validators.required,
    ]),
    NovaTarefaFormFields.itemTask: FormControl<String>(validators: [
      Validators.required,
    ]),
  });

  FormControl<String> get tituloTarefaControl => form.control(NovaTarefaFormFields.task) as FormControl<String>;
  FormControl<String> get itemTarefaControl => form.control(NovaTarefaFormFields.itemTask) as FormControl<String>;

  // ------------ Estado da página ---------------------

  String tituloTarefa = 'Criar tarefa';
  CriarTarefaInput tarefa = CriarTarefaInput(
    tituloTarefa: 'Criar Tarefa',
    idUsuario: 2,
    itens: const [],
  );

  List<ItemTarefa> listItens = [];
  bool showOptionsItens = false;
  bool showEllipsis = true;
  int indexItem = -1;

  RxNotifier isChecked = RxNotifier<bool>(false);

  setStateInitial() {
    setLoading();
    indexItem = -1;
    showOptionsItens = false;
    setState(tarefa);
  }

// -------- Função para adicionar título da tarefa --------
  addTituloTarefa() {
    bool isValid = true;

    if (!tituloTarefaControl.valid) {
      isValid = false;
      tituloTarefaControl.markAsTouched();
    }

    if (isValid) {
      tituloTarefa = tituloTarefaControl.value!;
    }

    tarefa = CriarTarefaInput(
      tituloTarefa: tituloTarefa,
      idUsuario: 2,
      itens: const [],
    );

    setState(tarefa);
  }

// -------- Função para adicionar itens localmente na tarefa --------
  addItensTaskList() {
    bool isValid = true;

    if (!itemTarefaControl.valid) {
      isValid = false;
      itemTarefaControl.markAsTouched();
    }

    if (isValid) {
      listItens.add(ItemTarefa(
        descricao: itemTarefaControl.value!,
        concluido: isChecked.value,
      ));
      itemTarefaControl.reset();
    }

    tarefa.itens = listItens;

    setStateInitial();
  }

  // ------ Função para alterar estado do atributo concluído do item ------
  onChangeConcluido(bool isChecked, ItemTarefa element) {
    setLoading();
    final indexItem = listItens.indexOf(element);
    listItens[indexItem].concluido = isChecked;
    setStateInitial();
  }

  // ------ Exibir opções de editar e excluir -----
  showEditOrDelete(ItemTarefa element) {
    setLoading();
    indexItem = listItens.indexOf(element);
    showOptionsItens = true;
    itemTarefaControl.reset();
    setState(tarefa);
  }

  // ------ Função para editar item da tarefa ------
  editItemTask(BuildContext context, ItemTarefa element) {
    itemTarefaControl.value = element.descricao;
    indexItem = listItens.indexOf(element);
    ToDoDialog.doubleButton(
      context,
      title: 'Editar',
      content: 'Informe o novo texto para essa tarefa',
      buttonLeftText: 'Confirmar',
      buttonRigthText: 'Cancelar',
      buttonLeftOnTap: () {
        setLoading();
        indexItem = listItens.indexOf(element);
        listItens[indexItem].descricao = itemTarefaControl.value!;
        showOptionsItens = false;
        showEllipsis = true;
        itemTarefaControl.reset();
        indexItem = -1;
        setState(tarefa);
        Modular.to.pop();
      },
      buttonRigthOnTap: () {
        setLoading();
        indexItem = -1;
        showOptionsItens = false;
        showEllipsis = true;
        itemTarefaControl.reset();
        setState(tarefa);
        Modular.to.pop();
      },
      widget: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Material(
          child: ReactiveForm(
            formGroup: form,
            child: TextInput(
              onTap: (() => setStateInitial()),
              formControl: itemTarefaControl,
              onSubmitted: () {
                setLoading();
                indexItem = listItens.indexOf(element);
                listItens[indexItem].descricao = itemTarefaControl.value!;
                showOptionsItens = false;
                showEllipsis = true;
                itemTarefaControl.reset();
                indexItem = -1;
                setState(tarefa);
                Modular.to.pop();
              },
              validationMessages: const {
                'required': 'Favor informar um item para essa tarefa',
              },
            ),
          ),
        ),
      ),
    ).show();
  }

  // ------ Função para excluir item da tarefa ------
  deleteItemTask(BuildContext context, ItemTarefa element) {
    indexItem = listItens.indexOf(element);
    ToDoDialog.doubleButton(
      context,
      title: 'Deletar',
      content: 'Você gostaria de deletar esse item?',
      buttonLeftText: 'Sim',
      buttonRigthText: 'Não',
      buttonLeftOnTap: () {
        setLoading();
        indexItem = listItens.indexOf(element);
        listItens.removeAt(indexItem);
        showOptionsItens = false;
        showEllipsis = true;
        indexItem = -1;
        setState(tarefa);
        Modular.to.pop();
      },
      buttonRigthOnTap: () {
        setLoading();
        indexItem = -1;
        showOptionsItens = false;
        showEllipsis = true;
        setState(tarefa);
        Modular.to.pop();
      },
    ).show();
  }

  // ----- Função para salvar um card de tarefas -----
  saveCardsTarefas(BuildContext context) async {
      if (listItens.isEmpty) {
      return ToDoDialog.singleButton(
        context,
        title: 'Atenção',
        content: 'Favor inserir um item nessa tarefa antes de salva-la!',
        buttonCenterOnTap: () => Modular.to.pop(),
      ).show();
    }



    final CriarTarefaInput input = CriarTarefaInput(
      idUsuario: 02,
      tituloTarefa: tituloTarefa,
      itens: listItens,
    );

    final result = await _criarTarefaUsecase.call(input);

    result.fold((failure) => false, (save) => true);

    Modular.to.pushNamed(HomeModule.home);
  }
}

class NovaTarefaFormFields {
  static String task = 'task';
  static String itemTask = 'itemTask';
}
