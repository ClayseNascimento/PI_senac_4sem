import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/src/@shared/interceptors/http_client.dart';
import 'package:todolist/src/data/datasources/to_do_list_datasource.dart';
import 'package:todolist/src/data/repositories/to_do_list_repository.dart';

class DataCoreModule {
  static List<Bind> get binds => [
        //datasources
        Bind.lazySingleton((i) => ToDoListDatasource(i<IHttpClient>())),

        // repositories
        Bind.lazySingleton((i) => ToDoListRepository(i<IToDoListDatasource>())),
      ];
}
