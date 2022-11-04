import 'package:reactive_forms/reactive_forms.dart';
import 'package:todolist/src/@shared/state/stores.dart';


class NovaTarefaStore extends TDStore<String> {
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
  List<String> listItens = [];

  setNameTask() {
    setState(nameTask);
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

  saveItensTask() {
    setLoading();
    bool isValid = true;

    if (!itemTaskControl.valid) {
      isValid = false;
      itemTaskControl.markAsTouched();
    }

    if (isValid) {
      setLoading();
      listItens.add(itemTaskControl.value!);
      itemTaskControl.reset();
      setState(itemTaskControl.value ?? '');
    }

    setState(itemTaskControl.value ?? '');
  }
}

class NovaTarefaFormFields {
  static String task = 'task';
  static String itemTask = 'itemTask';
}
