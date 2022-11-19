import express from 'express';
import { Pool, PoolClient } from 'pg';
import cors from 'cors';

import { Router, Request, Response } from 'express';
const app = express();
const route = Router()
app.use(express.json())
app.use(cors())

const pool = new Pool({
  user: "postgres",
  password: "postgres",
  host: "db_postgres",
  port: 5432,
  database: "todolist",
})

route.get('/', (req: Request, res: Response) => {
  res.json({ message: 'hello world with Typescript' })
})

route.post('/criarTarefa', async (req: Request, res: Response) => {
  const client: PoolClient = await pool.connect()
  const titulo: string = req.body.tituloTarefa;
  const usuario: number = req.body.idUsuario;
  const lista: Array<any> = req.body.itens;
  let values: string = 'values';

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
          const idTarefa: number = resultado[2].rows[0].id_tarefa;

          for (let i = 0; i < lista.length; i++) {
            let separator = i + 1 == lista.length ? '' : ',';
            values = values + `('${ lista[i].descricao }', ${ lista[i].concluido }, ${ idTarefa } )${ separator }`
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
  const client: PoolClient = await pool.connect()
  const idTarefa: number = req.body.idTarefa;
  const listaItens: Array<any> = req.body.itens;
  let values: string = 'values';
  let listaItensInsert: Array<any> = [];

  try {
    let sql_command = `begin transaction;`

    for (let i = 0; i < listaItens.length; i++) {
      if (listaItens[i].idItem > 0) {
        sql_command = `${ sql_command }
	                        update tarefas_itens
	                        set desc_item = '${ listaItens[i].descricao }',
	                            concluido = ${ listaItens[i].concluido }
	                        where id_item = ${ listaItens[i].idItem }
	                              and id_tarefa = ${ idTarefa };`

      } else {
        listaItensInsert.push(listaItens[i])
      }
    }

    console.log(sql_command);


    await client.query(sql_command)
      .catch(async e => {
        await client.query(`rollback;`)
        console.log('Erro ao alterar itens da tarefa.');
        throw new Error(e.message = 'Erro ao alterar itens da tarefa.');
      })

    if (listaItensInsert.length > 0) {
      for (let i = 0; i < listaItensInsert.length; i++) {
        let separator = i + 1 == listaItensInsert.length ? '' : ',';
        values = values + `('${ listaItensInsert[i].descricao }', ${ listaItensInsert[i].concluido }, ${ idTarefa } )${ separator }`
      }

      let sql_Insert_command;
      sql_Insert_command = `insert into tarefas_itens (desc_item, concluido, id_tarefa)
                            ${ values }`

      await client.query(sql_Insert_command)
        .catch(async e => {
          await client.query(`rollback;`)
          console.log('Erro ao adicionar itens da tarefa.');
          throw new Error(e.message = 'Erro ao alterar itens da tarefa.');
        })
    }

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
  const client: PoolClient = await pool.connect()
  const idItem: number = +req.params.idItemTarefa

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
  const client: PoolClient = await pool.connect()
  const idUser: number = +req.params.idUser
  let listTarefas: Array<any> = [];

  try {
    let sql_command = `select t.titulo_tarefa, ti.*
                       from tarefas t
                       join tarefas_itens ti 	on t.id_tarefa = ti.id_tarefa
                       join usuarios u  		on u.id_usuario  = t.id_usuario
                       where u.id_usuario = ${ idUser }
                       order by t.id_tarefa desc;`

    await client.query(sql_command)
      .then(result => {
        listTarefas = result.rows;
      })
      .catch(e => {
        throw new Error(e.message = 'Erro ao buscar lista de tarefas');
      })

    if (listTarefas) {
      const result = listTarefas.reduce((accumulator, current) => {
        let lista = [...accumulator]

        const indexFound = lista.findIndex((element: { idTarefa: any; }) => element.idTarefa == current.id_tarefa);

        if (indexFound >= 0) {
          lista[indexFound].itens.push({
            "idItem": current.id_item,
            "desc": current.desc_item,
            "concluido": current.concluido
          })

          return lista
        }

        lista.push({
          'idTarefa': current.id_tarefa,
          'tituloTarefa': current.titulo_tarefa,
          'itens': [
            {
              "idItem": current.id_item,
              "desc": current.desc_item,
              "concluido": current.concluido
            },
          ]
        })

        return lista

      }, new Map())

      res.setHeader("content-type", 'application/json')
      return res.send(result)
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
app.listen(3333, () => console.log('server running on: http://localhost:3333'))
