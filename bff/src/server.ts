import express from 'express';
import { Pool } from 'pg';

import { Router, Request, Response } from 'express';
const app = express();
const route = Router()
app.use(express.json())

const pool = new Pool({
  user: "postgres",
  password: "postgres",
  host: "localhost",
  port: 5432,
  database: "todolist",
})

route.get('/', (req: Request, res: Response) => {
  res.json({ message: 'hello world with Typescript' })
})

route.post('/criarTarefa', async (req: Request, res: Response) => {
  const client = await pool.connect()
  const titulo = req.body.tituloTarefa;
  const usuario = req.body.idUsuario;
  const lista: Array<any> = req.body.itens;
  let values = 'values';

  try {
    let sql_command = `begin transaction;

                         insert into tarefas (titulo_tarefa, id_usuario)
                         values('${ titulo }', ${ usuario });

                         select id_tarefa
                         from tarefas
                         where id_usuario = ${ usuario }
                         order by id_tarefa desc
                         limit 1;`

    await client.query(sql_command)
      .then(
        async resultado => {
          const idTarefa = resultado[2].rows[0].id_tarefa;

          for (let i = 0; i < lista.length; i++) {
            let separator = i + 1 == lista.length ? '' : ',';
            console.log(lista[i].desc);
            values = values + `('${ lista[i].desc }', ${ lista[i].concluido }, ${ idTarefa } )${ separator }`
          }

          sql_command = `insert into tarefas_itens (desc_item, concluido, id_tarefa)
                          ${ values }`

          await client.query(sql_command)
            .catch(async e => {
              await client.query(`rollback;`)
              throw new Error(e.message = 'Erro ao salvar os itens da tarefa');
            })
        }
      )
      .catch(async e => {
        await client.query(`rollback;`)
        throw new Error(e.message = 'Erro ao salvar uma tarefa');
      })

    await client.query(`commit;`)
    return res.status(201).send({ "sucesso": true });

  } catch (error) {
    await client.query(`rollback;`)
    return res.status(500).send({ "erro": error.message })

  } finally {
    client.release()
    console.log('desconectado');
  }
})

route.post('/alterarTarefa', async (req: Request, res: Response) => {
  const client = await pool.connect()
  const idTarefa = req.body.idTarefa;
  const listaItens: Array<any> = req.body.itens;

  try {
    let sql_command = `begin transaction;`

    for (let i = 0; i < listaItens.length; i++) {
      sql_command = `${ sql_command }
                        update tarefas_itens
                        set desc_item = '${ listaItens[i].desc }',
                            concluido = ${ listaItens[i].concluido }
                        where id_item = ${ listaItens[i].idItem }
                              and id_tarefa = ${ idTarefa };`

    }

    await client.query(sql_command)
      .catch(async e => {
        await client.query(`rollback;`)
        throw new Error(e.message = 'Erro ao alterar itens da tarefa.');
      })

    await client.query(`commit;`)
    return res.status(201).send({ "sucesso": true });

  } catch (error) {
    await client.query(`rollback;`)
    return res.status(500).send({ "erro": error.message })

  } finally {
    client.release()
    console.log('desconectado');
  }
})

route.delete('/itemTarefa/:idItemTarefa', async (req: Request, res: Response) => {
  const client = await pool.connect()
  const idItem = +req.params.idItemTarefa

  try {
    let sql_command = `begin transaction;
                      delete from tarefas_itens
                      where id_item = ${ idItem };`

    await client.query(sql_command)
      .catch(async e => {
        await client.query(`rollback;`)
        throw new Error(e.message = 'Erro ao excluir item da tarefa.');
      })

    await client.query(`commit;`)
    return res.status(200).send({ "sucesso": true });

  } catch (error) {
    await client.query(`rollback;`)
    return res.status(500).send({ "erro": error.message })

  } finally {
    client.release()
    console.log('desconectado');
  }
})

route.get('/tarefas/:idUser', async (req: Request, res: Response) => {
  const client = await pool.connect()
  const idUser = req.params.idUser
  let listTarefas = [];

  try {
    let sql_command = `select t.titulo_tarefa, ti.*
                       from tarefas t
                       join tarefas_itens ti 	on t.id_tarefa = ti.id_tarefa
                       join usuarios u  		on u.id_usuario  = t.id_usuario
                       where u.id_usuario = ${ idUser };`

   await client.query(sql_command)
      .then(result => {
        listTarefas = result.rows;
      })
      .catch(e => {
        throw new Error(e.message = 'Erro ao buscar lista de tarefas');
      })

    if (listTarefas) {
      return res.send(listTarefas)
    }

    return res.status(404).send([{ "erro": "Registros não encontrados" }])

  } catch (error) {
    return res.status(500).send({ "erro": error.message })
  }
  finally {
    client.release()
    console.log('desconectado');
  }
})

app.use(route)
app.listen(3333, () => 'server running on port 3333')
