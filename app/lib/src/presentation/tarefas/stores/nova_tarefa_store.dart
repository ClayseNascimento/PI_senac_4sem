import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todolist/src/@shared/alerts/todo_dialog.dart';
import 'package:todolist/src/@shared/inputs/text_input.dart';
import 'package:todolist/src/@shared/state/stores.dart';
import 'package:todolist/src/domain/entities/criar_tarefa_input.dart';
import 'package:todolist/src/domain/entities/item_tarefa.dart';
import 'package:todolist/src/domain/usecases/criar_tarefa_usecase.dart';
import 'package:todolist/src/presentation/home/home_module.dart';
import 'package:rx_notifier/rx_notifier.dart';

class NovaTarefaStore extends TDStore<String> {
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

  FormControl<String> get nameTaskControl => form.control(NovaTarefaFormFields.task) as FormControl<String>;
  FormControl<String> get itemTaskControl => form.control(NovaTarefaFormFields.itemTask) as FormControl<String>;

  // ------------ Estado da página ---------------------

  String nameTask = 'Criar tarefa';
  List<ItemTarefa> listItens = [];
  bool showOptionsItens = false;
  bool showEllipsis = true;
  int indexItem = -1;
  List<ItemTarefa> listTarefas = [];

  RxNotifier isChecked = RxNotifier<bool>(false);

  setStateInitial() {
    setLoading();
    indexItem = -1;
    showOptionsItens = false;
    setState(nameTask);
  }

  setStateAfterSave() {
    setLoading();
    nameTaskControl.reset();
    itemTaskControl.reset();
    nameTask = 'Criar tarefa';
    listItens = [];
    showOptionsItens = false;
    showEllipsis = true;
    indexItem = -1;
    listTarefas = [];
    setState('');
  }

  saveTitleTask() {
    setLoading();
    bool isValid = true;

    if (!nameTaskControl.valid) {
      isValid = false;
      nameTaskControl.markAsTouched();
    }

    if (isValid) {
      nameTask = nameTaskControl.value!;
    }
    setState(nameTask);
  }

  addItensTaskList() {
    setLoading();
    bool isValid = true;

    if (!itemTaskControl.valid) {
      isValid = false;
      itemTaskControl.markAsTouched();
    }

    if (isValid) {
      setLoading();
      listItens.add(ItemTarefa(descricao: itemTaskControl.value!, concluido: isChecked.value));
      itemTaskControl.reset();
      setState(itemTaskControl.value ?? '');
    }

    setStateInitial();
    setState(itemTaskControl.value ?? '');
  }
  
  // ------ Exibir opções de editar e excluir -----
  showEditOrDelete(ItemTarefa element) {
    setLoading();
    indexItem = listItens.indexOf(element);
    showOptionsItens = true;
    setState(itemTaskControl.value ?? '');
  }

  // ------ Função para editar item da tarefa ------
  editItemTask(BuildContext context, ItemTarefa element) {
    setLoading();
    itemTaskControl.value = element.descricao;
    indexItem = listItens.indexOf(element);
    ToDoDialog(
      context: context,
      title: 'Editar',
      content: 'Informe o novo texto para essa tarefa',
      buttonLeftText: 'Confirmar',
      buttonRigthText: 'Cancelar',
      buttonLeftOnTap: () {
        setLoading();
        indexItem = listItens.indexOf(element);
        // listItens[indexItem] = itemTaskControl.value!;
        showOptionsItens = false;
        showEllipsis = true;
        itemTaskControl.reset();
        indexItem = -1;
        setState(itemTaskControl.value ?? '');
        Modular.to.pop();
      },
      buttonRigthOnTap: () {
        setLoading();
        indexItem = -1;
        showOptionsItens = false;
        showEllipsis = true;
        itemTaskControl.reset();
        setState(itemTaskControl.value ?? '');
        Modular.to.pop();
      },
      widget: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Material(
          child: ReactiveForm(
            formGroup: form,
            child: TextInput(
              onTap: (() => setStateInitial()),
              formControl: itemTaskControl,
              hintText: 'Adicionar novo item',
              onSubmitted: () {
                setLoading();
                indexItem = listItens.indexOf(element);
                // listItens[indexItem] = itemTaskControl.value!;
                showOptionsItens = false;
                showEllipsis = true;
                itemTaskControl.reset();
                setState(itemTaskControl.value ?? '');
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
    setState(itemTaskControl.value ?? '');
  }

  // ------ Função para excluir item da tarefa ------
  deleteItemTask(BuildContext context, ItemTarefa element) {
    setLoading();
    indexItem = listItens.indexOf(element);
    ToDoDialog(
      context: context,
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
        setState(itemTaskControl.value ?? '');
        Modular.to.pop();
      },
      buttonRigthOnTap: () {
        setLoading();
        indexItem = -1;
        showOptionsItens = false;
        showEllipsis = true;
        setState(itemTaskControl.value ?? '');
        Modular.to.pop();
      },
    ).show();
    setState(itemTaskControl.value ?? '');
  }

  // ----- Função para salvar um card de tarefas -----
  saveCardsTarefas() async {
    setLoading();

    for (var item in listItens) {
      listTarefas.add(ItemTarefa(
        descricao: item.descricao,
        concluido: item.concluido,
      ));
    }

    final CriarTarefaInput input = CriarTarefaInput(
      idUsuario: 02,
      tituloTarefa: nameTask,
      itens: listTarefas,
    );

    final result = await _criarTarefaUsecase.call(input);

    result.fold((failure) => false, (save) => true);

    Modular.to.pushNamed(HomeModule.home);
    setStateAfterSave();
  }
}

class NovaTarefaFormFields {
  static String task = 'task';
  static String itemTask = 'itemTask';
}
