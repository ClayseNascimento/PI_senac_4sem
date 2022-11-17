import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todolist/src/@shared/alerts/todo_dialog.dart';
import 'package:todolist/src/@shared/inputs/text_input.dart';
import 'package:todolist/src/@shared/state/stores.dart';
import 'package:todolist/src/domain/entities/alterar_tarefa_input.dart';
import 'package:todolist/src/domain/entities/item_tarefa.dart';
import 'package:todolist/src/domain/usecases/alterar_tarefa_usecase.dart';
import 'package:todolist/src/presentation/home/home_module.dart';
import 'package:rx_notifier/rx_notifier.dart';

class EditarTarefaStore extends TDStore<List<ItemTarefa>> {
  final AlterarTarefaUsecase _alterarTarefaUsecase;

  EditarTarefaStore(this._alterarTarefaUsecase);

  // -------------- Controller input--------------------
  final FormGroup form = FormGroup({
    NovaTarefaFormFields.itemTask: FormControl<String>(validators: [
      Validators.required,
    ]),
  });

  FormControl<String> get itemTaskControl => form.control(NovaTarefaFormFields.itemTask) as FormControl<String>;

  // ------------ Estado da página ---------------------

  String nameTask = 'Criar tarefa';
  List<ItemTarefa> listItens = [];
  bool showOptionsItens = false;
  bool showEllipsis = true;
  int indexItem = -1;

  RxNotifier isChecked = RxNotifier<bool>(false);

  setStateInitial() {
    setLoading();
    indexItem = -1;
    showOptionsItens = false;
    setState(listItens);
  }

  // ------ Armazenar localmente informações da tarefa -----
  getItensTarefa(List<ItemTarefa> itens) {
    listItens = itens;
    setState(listItens);
  }

  // ------ Exibir opções de editar e excluir -----
  showEditOrDelete(ItemTarefa element) {
    setLoading();
    indexItem = element.idItem ?? listItens.indexOf(element);
    showOptionsItens = true;
    itemTaskControl.reset();
    setState(listItens);
  }

  // ------ Adicionar novos itens na lista local -----
  addItensListItens() {
    setLoading();
    bool isValid = true;

    if (!itemTaskControl.valid) {
      isValid = false;
      itemTaskControl.markAsTouched();
    }

    if (isValid) {
      setLoading();
      listItens.add(ItemTarefa(
        descricao: itemTaskControl.value!,
        concluido: isChecked.value,
      ));
      itemTaskControl.reset();
      setState(listItens);
    }

    setStateInitial();
    setState(listItens);
  }

  // ------ Função para editar item da tarefa ------
  editItemTask(BuildContext context, ItemTarefa element) {
    setLoading();
    itemTaskControl.value = element.descricao;
    indexItem = listItens.indexOf(element);
    ToDoDialog(
      context: context,
      title: 'Editar',
      content: 'Informe o novo texto para esse item',
      buttonLeftText: 'Confirmar',
      buttonRigthText: 'Cancelar',
      buttonLeftOnTap: () {
        indexItem = listItens.indexOf(element);
        listItens[indexItem].descricao = itemTaskControl.value!;
        showOptionsItens = false;
        showEllipsis = true;
        itemTaskControl.reset();
        indexItem = -1;
        setState(listItens);
        Modular.to.pop();
      },
      buttonRigthOnTap: () {
        setLoading();
        indexItem = -1;
        showOptionsItens = false;
        showEllipsis = true;
        itemTaskControl.reset();
        setState(listItens);
        Modular.to.pop();
      },
      widget: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Material(
          child: ReactiveForm(
            formGroup: form,
            child: TextInput(
              formControl: itemTaskControl,
              onSubmitted: () {
                setLoading();
                indexItem = listItens.indexOf(element);
                listItens[indexItem].descricao = itemTaskControl.value!;
                showOptionsItens = false;
                showEllipsis = true;
                itemTaskControl.reset();
                setState(listItens);
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
    setState(listItens);
  }

  // ------ Função para alterar estado do atributo concluído do item ------
  onChangeConcluido(bool isChecked, ItemTarefa element) {
    final indexItem = listItens.indexOf(element);
    listItens[indexItem].concluido = isChecked;
    setState(listItens);
    setStateInitial();
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
        // showOptionsItens = false;
        showEllipsis = true;
        indexItem = -1;
        // setState(itemTaskControl.value ?? '');
        Modular.to.pop();
      },
      buttonRigthOnTap: () {
        setLoading();
        indexItem = -1;
        // showOptionsItens = false;
        showEllipsis = true;
        // setState(itemTaskControl.value ?? '');
        Modular.to.pop();
      },
    ).show();
    // setState(itemTaskControl.value ?? '');
  }

  // ----- Função para salvar alterações do card de tarefas -----
  saveCardsTarefas(int idTarefa) async {
    setLoading();

    final AlterarTarefaInput input = AlterarTarefaInput(
      idUsuario: 02,
      idTarefa: idTarefa,
      itens: listItens,
    );

    final result = await _alterarTarefaUsecase.call(input);

    result.fold((failure) => false, (save) => true);

    Modular.to.pushNamed(HomeModule.home);
    setState(listItens);
  }
}

class NovaTarefaFormFields {
  static String task = 'task';
  static String itemTask = 'itemTask';
}
